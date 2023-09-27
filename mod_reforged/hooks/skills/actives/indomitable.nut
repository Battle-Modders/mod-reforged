::Reforged.HooksMod.hook("scripts/skills/actives/indomitable", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Become immune to being [culled|Perk+perk_rf_cull]")
		});
		return ret;
	}
});
