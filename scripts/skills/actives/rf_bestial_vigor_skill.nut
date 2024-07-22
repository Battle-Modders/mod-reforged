this.rf_bestial_vigor_skill <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueRecoveredFraction = 1.0,
		ActionPointsGained = 3,
		IsSpent = false,
		IsBonusActive = false
	},
	function create()
	{
		this.m.ID = "actives.rf_bestial_vigor";
		this.m.Name = "Bestial Vigor";
		this.m.Description = "Unleash your beastly vigor to shake off the effects of Fatigue and push your body beyond limits!";
		this.m.Icon = "skills/rf_bestial_vigor_skill.png";
		this.m.IconDisabled = "skills/rf_bestial_vigor_skill_sw.png";
		this.m.Overlay = "rf_bestial_vigor_skill";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_linebreaker_01.wav",
			"sounds/enemies/orc_linebreaker_02.wav",
			"sounds/enemies/orc_linebreaker_03.wav",
			"sounds/enemies/orc_linebreaker_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Current Fatigue is reduced by " + ::MSU.Text.colorizeFraction(this.m.FatigueRecoveredFraction)
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Gain " + ::MSU.Text.colorizeValue(this.m.ActionPointsGained) + " Action Points for this turn"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is only usable " + ::MSU.Text.colorNegative("once") + " per combat"
			}
		]);

		return tooltip;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;
		this.m.IsBonusActive = true;

		local actor = this.getContainer().getActor();
		actor.setFatigue(actor.getFatigue() * (1.0 - this.m.FatigueRecoveredFraction));
		actor.setActionPoints(actor.getActionPoints() + this.m.ActionPointsGained);

		return true;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsBonusActive) _properties.ActionPoints += this.m.ActionPointsGained;
	}

	function onTurnEnd()
	{
		this.m.IsBonusActive = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
		this.m.IsBonusActive = false;
	}
});
