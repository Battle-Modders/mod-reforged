this.rf_onslaught_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false	
	},
	function create()
	{
		this.m.ID = "actives.rf_onslaught";
		this.m.Name = "Onslaught";
		this.m.Description = "Order your men to push through the enemy lines!"
		this.m.Icon = "skills/rf_onslaught_skill.png";
		this.m.IconDisabled = "skills/rf_onslaught_skill_bw.png";
		this.m.Overlay = "rf_onslaught_skill";
		this.m.SoundOnUse = [
			"sounds/combat/onslaughtv9_01.wav",
			"sounds/combat/onslaughtv9_02.wav",
			"sounds/combat/onslaughtv9_03.wav"
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
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Onslaught;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Affects all allies within [color=" + ::Const.UI.Color.PositiveValue + "]4[/color] tiles who have at least [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue remaining and are not Stunned or Fleeing"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Affected allies build [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Affected allies and you gain the [Onslaught|Skill+rf_onslaught_effect] effect for one turn")
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("Cannot be used more than once per combat (company-wide)")
		});

		if (this.m.IsSpent)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Has already been used by the company in this combat")
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
				local skill = bro.getSkills().getSkillByID("actives.rf_onslaught");
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
				this.getContainer().add(::new("scripts/skills/effects/rf_onslaught_effect"));
			}
			else
			{
				if (ally.getTile().getDistanceTo(myTile) <= 4 && ally.getFatigueMax() - ally.getFatigue() >= 10)
				{
					ally.setFatigue(ally.getFatigue() + 10);
					local effect = ::new("scripts/skills/effects/rf_onslaught_effect");
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
