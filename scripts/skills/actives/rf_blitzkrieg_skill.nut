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
		this.m.IconDisabled = "skills/rf_blitzkrieg_skill_bw.png";
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
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Blitzkrieg;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Every ally within [color=" + ::Const.UI.Color.PositiveValue + "]4[/color] tiles who has at least [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue remaining and is not Stunned or Fleeing will get the Adrenaline effect and build [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used more than once per day (company-wide)[/color]"
		});

		if (this.m.IsSpent)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Has already been used by the company this day")
			});
		}

		return tooltip;
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
