this.rf_between_the_eyes_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_between_the_eyes";
		this.m.Name = "Between the Eyes";
		this.m.Description = "Attempt to land your next attack right between your target\'s eyes.";
		this.m.Icon = "skills/rf_between_the_eyes_skill.png";
		this.m.IconDisabled = "skills/rf_between_the_eyes_skill_sw.png";
		this.m.Overlay = "rf_between_the_eyes_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 50;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 10;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		local effect = ::new("scripts/skills/effects/rf_between_the_eyes_effect");
		effect.m.Container = this.getContainer();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Gain the " + ::Reforged.NestedTooltips.getNestedSkillName(effect) + " effect"))
			children = effect.getTooltip().slice(2) // slice 2 to remove name and description
		});

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		_user.getSkills().add(::new("scripts/skills/effects/rf_between_the_eyes_effect"));
		return true;
	}
});
