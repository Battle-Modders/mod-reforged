this.rf_polearm_adjacency <- ::inherit("scripts/skills/skill", {
	m = {
		MeleeSkillModifierPerEnemy = -10,
		MeleeSkillModifierPerAlly = 0,
		NumEnemiesToIgnore = 0,
		NumAlliesToIgnore = 0
	},
	function create()
	{
		this.m.ID = "special.rf_polearm_adjacency";
		this.m.Name = "Crowded";
		this.m.Description = "Long range melee weapons are harder to use in a crowded environment. When using such weapons, any melee attack with a base range of 2 or more tiles may have its hitchance reduced.";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	// Reset all our fields because certain skills/effects may modify them temporarily during update
	function softReset()
	{
		this.skill.softReset();
		foreach (k, _ in this.m)
		{
			this.resetField(k);
		}
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.MeleeSkillModifierPerEnemy != 0 && this.m.NumEnemiesToIgnore < 6)
		{
			local numIgnoreString = this.m.NumEnemiesToIgnore == 0 ? "" : " excluding " + this.m.NumEnemiesToIgnore + " enemies";
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("%s chance to hit per adjacent enemy%s", ::MSU.Text.colorizeValue(this.m.MeleeSkillModifierPerEnemy, {AddSign = true, AddPercent = true}), numIgnoreString))
			});
		}

		if (this.m.MeleeSkillModifierPerAlly != 0 && this.m.NumAlliesToIgnore < 6)
		{
			local numIgnoreString = this.m.NumAlliesToIgnore == 0 ? "" : " excluding " + this.m.NumAlliesToIgnore + " allies";
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("%s chance to hit per adjacent ally%s", ::MSU.Text.colorizeValue(this.m.MeleeSkillModifierPerAlly, {AddSign = true, AddPercent = true}), numIgnoreString))
			});
		}

		return ret;
	}

	function isEnabledForSkill( _skill )
	{
		return _skill.getMaxRange() > 1 && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.MeleeSkill += this.getModifierForSkill(_skill);
	}

	function getModifierForSkill( _skill )
	{
		if (!this.isEnabledForSkill(_skill))
			return 0;

		local user = this.getContainer().getActor();
		if (!user.isPlacedOnMap())
			return 0;

		local numAllies = 0;
		local numEnemies = 0;
		local myTile = user.getTile();
		for (local i = 0; i < 6; i++)
		{
			if (!myTile.hasNextTile(i)) continue;
			local nextTile = myTile.getNextTile(i);
			if (!nextTile.IsOccupiedByActor) continue;

			local nextEntity = nextTile.getEntity();
			if (nextEntity.isAlliedWith(user)) numAllies++;
			else numEnemies++;
		}

		return (this.m.MeleeSkillModifierPerAlly * ::Math.max(0, numAllies - this.m.NumAlliesToIgnore)) + (this.m.MeleeSkillModifierPerEnemy * ::Math.max(0, numEnemies - this.m.NumEnemiesToIgnore));
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local modifier = this.getModifierForSkill(_skill);
		if (modifier < 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(modifier, {AddPercent = true}) + " " + ::Reforged.NestedTooltips.getNestedSkillName(this))
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isEnabledForSkill(_skill))
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Can be affected by " + ::Reforged.NestedTooltips.getNestedSkillName(this))
			});
		}
	}
});
