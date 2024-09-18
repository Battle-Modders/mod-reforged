this.rf_blitzkrieg_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.rf_blitzkrieg";
		this.m.Name = "Blitzkrieg";
		this.m.Description = "Order your men to attack as fast as possible!"
		this.m.Icon = "skills/rf_blitzkrieg_skill.png";
		this.m.IconDisabled = "skills/rf_blitzkrieg_skill_sw.png";
		this.m.Overlay = "rf_blitzkrieg_skill";
		this.m.SoundOnUse = [
			"sounds/combat/rf_blitzkrieg_skill_1.wav",
			"sounds/combat/rf_blitzkrieg_skill_2.wav"
			"sounds/combat/rf_blitzkrieg_skill_3.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Blitzkrieg;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("You and allies of your faction within " + ::MSU.Text.colorPositive("4") + " tiles who have at least " + ::MSU.Text.colorNegative("10") + " [Fatigue|Concept.Fatigue] remaining gain the [Adrenaline|Skill+adrenaline_effect] effect and build " + ::MSU.Text.colorNegative("10") + " [Fatigue|Concept.Fatigue]")
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Does not affect allies who are [fleeing,|Concept.Morale] [stunned,|Skill+stunned_effect] or [sleeping|Skill+sleeping_effect]")
		});

		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Cannot be used more than once per day (company-wide)"
		});

		if (this.m.IsSpent)
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Has already been used by the company this day")
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
				local skill = bro.getSkills().getSkillByID("actives.rf_blitzkrieg");
				if (skill != null) skill.m.IsSpent = true;
			}
		}

		local myTile = _user.getTile();

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()))
		{
			if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsStunned)
			{
				continue;
			}

			if (ally.getID() == _user.getID())
			{
				this.getContainer().add(::new("scripts/skills/effects/adrenaline_effect"));
			}
			else
			{
				if (ally.getTile().getDistanceTo(myTile) <= 4 && ally.getFatigueMax() - ally.getFatigue() >= 10)
				{
					ally.setFatigue(ally.getFatigue() + 10);
					local effect = ::new("scripts/skills/effects/adrenaline_effect");
					if (!ally.isTurnStarted() && !ally.isTurnDone())
					{
						effect.m.TurnsLeft++;
					}
					ally.getSkills().add(effect);
				}
			}
		}

		return true;
	}

	function onNewMorning()
	{
		this.m.IsSpent = false;
	}
});
