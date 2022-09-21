this.rf_hold_the_line_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false	
	},
	function create()
	{
		this.m.ID = "actives.rf_hold_the_line";
		this.m.Name = "Hold the Line";
		this.m.Description = "Order your men to hold their ground!"
		this.m.Icon = "skills/rf_hold_the_line_skill.png";
		this.m.IconDisabled = "skills/rf_hold_the_line_skill_bw.png";
		this.m.Overlay = "rf_hold_the_line_skill";
		this.m.SoundOnUse = [];
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
		this.m.AIBehavior = {
			ID = ::Const.AI.Behavior.ID.RF_HoldTheLine,
			Script = "scripts/ai/tactical/behaviors/ai_rf_hold_the_line"
		};
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
			text = "Affected allies and you gain the \'Holding the Line\' effect which grants " + ::MSU.Text.colorizeValue(10) + " Melee Defense, " + ::MSU.Text.colorizeValue(10) + " Ranged Defense and " + ::MSU.Text.colorGreen("immunity") + " to being Stunned, Knocked Back or Grabbed for one turn"
		});

		if (this.m.IsSpent)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used more than once per combat (company-wide)")
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
				local skill = bro.getSkills().getSkillByID("actives.rf_hold_the_line");
				if (skill != null) skill.m.IsSpent = true;
			}
		}

		local myTile = _user.getTile();

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()))
		{
			local skill = ally.getSkills().getSkillByID("actives.rf_hold_the_line");
			if (skill != null) skill.m.IsSpent = true;

			if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsStunned)
			{
				continue;
			}

			if (ally.getID() == _user.getID())
			{
				this.getContainer().add(::new("scripts/skills/effects/rf_hold_the_line_effect"));
			}
			else
			{
				if (ally.getTile().getDistanceTo(myTile) <= 4 && ally.getFatigueMax() - ally.getFatigue() >= 10)
				{
					ally.setFatigue(ally.getFatigue() + 10);
					bro.getSkills().add(::new("scripts/skills/effects/rf_hold_the_line_effect"));
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
