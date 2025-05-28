::Reforged.HooksMod.hook("scripts/skills/actives/kraken_ensnare_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Trap the target using a giant tentacle to slowly drag them towards you!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target gains the [Entangled|Skill+kraken_ensnare_effect] effect")
		});
		return ret;
	}}.getTooltip;
});
