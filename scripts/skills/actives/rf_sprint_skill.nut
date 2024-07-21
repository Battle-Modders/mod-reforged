this.rf_sprint_skill <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 1.5
	},
	function create()
	{
		this.m.ID = "actives.rf_sprint";
		this.m.Name = "Sprint";
		this.m.Description = "Get to your destination as fast as possible!";
		this.m.Icon = "skills/rf_sprint_skill.png";
		this.m.IconDisabled = "skills/rf_sprint_skill_sw.png";
		this.m.Overlay = "rf_sprint_skill";
		this.m.SoundOnUse = [
			"sounds/humans/3/human_flee_03.wav"
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 10;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "Action Point cost for movement on all terrain will be reduced by " + ::MSU.Text.colorPositive(1)
		});

		if (this.m.FatigueMult != 1.0)
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue cost for movement on all terrain will be increased by " + ::MSU.Text.colorizeMult(this.m.FatigueMult, {InvertColor = true})
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while rooted")
			});
		}

		return tooltip;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted && !this.getContainer().hasSkill("effects.rf_sprint");
	}

	function onUse( _user, _targetTile )
	{
		local sprintEffect = ::new("scripts/skills/effects/rf_sprint_effect");
		sprintEffect.m.FatigueMult = this.m.FatigueMult;
		this.getContainer().add(sprintEffect);
		return true;
	}
});
