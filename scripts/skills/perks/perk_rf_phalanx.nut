this.perk_rf_phalanx <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_phalanx";
		this.m.Name = ::Const.Strings.PerkName.RF_Phalanx;
		this.m.Description = "This character is highly skilled in fighting in a shielded formation and gains bonuses when adjacent to allies with shields.";
		this.m.Icon = "ui/perks/rf_phalanx.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap() || this.getCount() == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::MSU.Text.colorizeValue(this.getCount()) + " Reach when attacking or defending in melee"
		});

		if (this.hasAdjacentShieldwall())
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Shieldwall|Skill+shieldwall_effect] will not expire at the start of your [turn|Concept.Turn] as you are next to an ally with [Shieldwall|Skill+shieldwall_effect]")
			});
		}

		return tooltip;
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

	function onTurnStart()
	{
		if (this.hasAdjacentShieldwall())
		{
			foreach (skill in this.getContainer().m.Skills)
			{
				if (skill.getID() == "effects.shieldwall")
				{
					skill.m.IsGarbage = false; // Because Phalanx skill order is after Shieldwall effect, so we retroactively set it to not be garbage
					return;
				}
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
		if (_skill.getID() == "effects.shieldwall" && this.hasAdjacentShieldwall())
		{
			_tooltip.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will not expire as you have [Phalanx|Perk+perk_rf_phalanx] and are next to an ally with [Shieldwall|Skill+shieldwall_effect]")
			});
		}
	}

	function hasAdjacentShieldwall()
	{
		local actor = this.getContainer().getActor();
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
