this.rf_sprint_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_sprint";
		this.m.Name = "Sprint";
		this.m.Description = "Run Forrest run!";
		this.m.Icon = "skills/rf_sprint_skill.png";
		this.m.IconDisabled = "skills/rf_sprint_skill_bw.png";
		this.m.Overlay = "rf_sprint_skill";
		this.m.SoundOnUse = [
			"sounds/humans/3/human_flee_03.wav"
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 10;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Action Point cost for movement on all terrain will be reduced by " + ::MSU.Text.colorGreen(1)
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue cost for movement on all terrain will be increased by " + ::MSU.Text.colorRed("50%")
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used while rooted")
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
		this.getContainer().add(::new("scripts/skills/effects/rf_sprint_effect"));
		return true;
	}
});
