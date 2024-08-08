this.rf_hold_steady_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.rf_hold_steady";
		this.m.Name = "Hold Steady";
		this.m.Description = "Order your men to hold their ground!"
		this.m.Icon = "skills/rf_hold_steady_skill.png";
		this.m.IconDisabled = "skills/rf_hold_steady_skill_sw.png";
		this.m.Overlay = "rf_hold_steady_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_HoldSteady;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("You and your allies within " + ::MSU.Text.colorPositive(4) " tiles gain the [Holding Steady|Skill+rf_hold_steady_effect] effect for one [turn|Concept.Turn]")
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will not affect allies who are [fleeing,|Concept.Morale] [stunned,|Skill+stunned_effect] or [sleeping|Skill+sleeping_effect]"
		});

		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Cannot be used more than once per battle (company-wide)"
		});

		if (this.m.IsSpent)
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Has already been used by the company in this battle")
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;

		if (_user.isPlayerControlled())
		{
			local rosterBros = ::World.getPlayerRoster().getAll();
			foreach (bro in rosterBros)
			{
				local skill = bro.getSkills().getSkillByID("actives.rf_hold_steady");
				if (skill != null) skill.m.IsSpent = true;
			}
		}

		local myTile = _user.getTile();

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()))
		{
			local skill = ally.getSkills().getSkillByID("actives.rf_hold_steady");
			if (skill != null) skill.m.IsSpent = true;

			if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsStunned)
			{
				continue;
			}

			if (ally.getID() == _user.getID())
			{
				this.getContainer().add(::new("scripts/skills/effects/rf_hold_steady_effect"));
			}
			else
			{
				if (ally.getTile().getDistanceTo(myTile) <= 4)
				{
					local effect = ::new("scripts/skills/effects/rf_hold_steady_effect");
					if (!ally.isTurnStarted() && !ally.isTurnDone())
					{
						// If the ally has not started their turn yet in this round, add one more turn
						// so that the effect doesn't immediately expire upon the ally's turn starting
						effect.m.TurnsLeft++;
					}
					ally.getSkills().add(effect);
				}
			}
		}

		return true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
	}
});
