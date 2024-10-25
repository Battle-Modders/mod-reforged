this.perk_rf_phalanx <- ::inherit("scripts/skills/skill", {
	m = {
		ShieldWallActionPointsMult = 0.5,
		ShieldWallActionPointsMininum = 2,	// This perk can't reduce the AP of shieldwall below this value
		ShieldWallFatigueMult = 0.5
	},
	function create()
	{
		this.m.ID = "perk.rf_phalanx";
		this.m.Name = ::Const.Strings.PerkName.RF_Phalanx;
		this.m.Description = "This character is highly skilled in fighting in a shielded formation and gains bonuses when adjacent to allies with shields.";
		this.m.Icon = "ui/perks/perk_rf_phalanx.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
	}

	function isHidden()
	{
		return this.getCount() == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getCount(), {AddSign = true}) + " [Reach|Concept.Reach] when attacking or defending in melee")
		});

		if (this.hasAdjacentShieldwall() || this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Shieldwall|Skill+shieldwall] costs " + ::MSU.Text.colorizeMultWithText(this.m.ShieldWallActionPointsMult, {InvertColor = true}) + " [Action Points|Concept.ActionPoints] (up to a minimum of " + ::MSU.Text.colorPositive(this.m.ShieldWallActionPointsMininum) + ") and " + ::MSU.Text.colorizeMultWithText(this.m.ShieldWallFatigueMult, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill.isAttack() && !_skill.isRanged())
		{
			_properties.Reach += this.getCount();
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			_properties.Reach += this.getCount();
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.hasAdjacentShieldwall())
		{
			local shieldwallSkill = this.getContainer().getSkillByID("actives.shieldwall");
			if (shieldwallSkill != null)
			{
				shieldwallSkill.m.ActionPointCost = ::Math.max(shieldwallSkill.m.ActionPointCost * this.m.ShieldWallActionPointsMult, this.m.ShieldWallActionPointsMininum);
				shieldwallSkill.m.FatigueCostMult *= this.m.ShieldWallFatigueMult;
			}
		}
	}

	function getCount()
	{
		local ret = 0;
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !actor.isArmedWithShield() || actor.getOffhandItem().getID().find("buckler") != null)
		{
			return ret;
		}

		foreach (ally in ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1))
		{
			if (ally.isArmedWithShield() && actor.getOffhandItem().getID().find("buckler") == null && ally.getID() != actor.getID())
			{
				ret += 1;
			}
		}

		return ret;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _targetTile.IsOccupiedByActor && this.getCount() != 0 && ::Reforged.Reach.hasLineOfSight(this.getContainer().getActor(), _targetTile.getEntity()))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (_skill.isAttack() && !_skill.isRanged() && this.getCount() != 0 && ::Reforged.Reach.hasLineOfSight(_skill.getContainer().getActor(), this.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = this.getName()
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.shieldwall" && this.hasAdjacentShieldwall())
		{
			_tooltip.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Costs " + ::MSU.Text.colorizeMultWithText(this.m.ShieldWallActionPointsMult, {InvertColor = true}) + " [Action Points|Concept.ActionPoints] (up to a minimum of " + ::MSU.Text.colorPositive(this.m.ShieldWallActionPointsMininum) + ") and " + ::MSU.Text.colorizeMultWithText(this.m.ShieldWallFatigueMult, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}
	}

	function hasAdjacentShieldwall()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return false;

		local myTile = actor.getTile();
		for (local i = 0; i < 6; i++)
		{
			if (!myTile.hasNextTile(i))
				continue;

			local nextTile = myTile.getNextTile(i);
			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAlliedWith(actor) && nextTile.getEntity().getSkills().hasSkill("effects.shieldwall"))
				return true;
		}

		return false;
	}
});
