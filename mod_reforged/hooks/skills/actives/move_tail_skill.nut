::Reforged.HooksMod.hook("scripts/skills/actives/move_tail_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Bring your tail along with you wherever you go!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Brings your tail next to you ignoring [zone of control|Concept.ZoneOfControl]")
		});
		return ret;
	}}.getTooltip;
});
