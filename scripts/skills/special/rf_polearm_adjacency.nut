this.rf_polearm_adjacency <- ::inherit("scripts/skills/skill", {
	m = {
		MalusPerAlly = 0, // not currently utilizing this feature
		MalusPerEnemy = 10,
		NumAlliesToIgnore = 0 // not currently utilizing this feature
	},
	function create()
	{
		this.m.ID = "special.rf_polearm_adjacency";
		this.m.Name = "Crowded";
		this.m.Description = "Long range melee weapons are harder to use in a crowded environment. When using such weapons, any melee attack with a base range of 2 or more tiles has its hit chance reduced by " + ::MSU.Text.colorizeValue(-this.m.MalusPerEnemy, {AddSign = true, AddPercent = true}) + " per adjacent enemy.";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.getRangeMax() > 1)
		{
			return true;
		}

		return false;
	}

	function isEnabledForSkill( _skill )
	{
		return _skill.getMaxRange() > 1 && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.MeleeSkill -= this.getMalusForSkill(_skill);
	}

	function getMalusForSkill( _skill )
	{
		if (!this.isEnabledForSkill(_skill) || !this.isEnabled())
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

		return (this.m.MalusPerAlly * ::Math.max(0, numAllies - this.m.NumAlliesToIgnore)) + (this.m.MalusPerEnemy * numEnemies);
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local malus = this.getMalusForSkill(_skill);
		if (malus > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(-malus, {AddSign = true, AddPercent = true}) + " [Crowded|Skill+rf_polearm_adjacency]")
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isEnabled() && this.isEnabledForSkill(_skill))
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("May have [reduced chance to hit|Skill+rf_polearm_adjacency] when standing next to enemies")
			});
		}
	}
});
