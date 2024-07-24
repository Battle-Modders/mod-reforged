this.rf_sprint_skill <- ::inherit("scripts/skills/skill", {
	m = {},
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
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Sprinting|Skill+rf_sprint_effect] effect")
		});

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while rooted")
			});
		}

		return ret;
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
