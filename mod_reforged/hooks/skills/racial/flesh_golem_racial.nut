::Reforged.HooksMod.hook("scripts/skills/racial/flesh_golem_racial", function(q) {
	q.m.InjuryThresholdMult <- 0.7;
	q.m.MovementAPCostModifier <- 2;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Name = "Flesh Golem";
		this.m.Icon = "ui/orientation/flesh_golem_orientation.png";
		this.m.IsHidden = false;
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/asset_medicine.png",	// This is not an ideal icon but more unique than special, and at least closely related
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.InjuryThresholdMult) + " [Injury Threshold|Concept.InjuryThreshold]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Moving costs " + ::MSU.Text.colorizeValue(this.m.MovementAPCostModifier, {AddSign = true, InvertColor = true}) + ::Reforged.Mod.Tooltips.parseString(" [Action Points|Concept.ActionPoints] per tile")
			}
		]);
		return ret;
	}}.getTooltip;
});
