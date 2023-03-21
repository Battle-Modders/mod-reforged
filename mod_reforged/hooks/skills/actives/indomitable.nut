::mods_hookExactClass("skills/actives/indomitable", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Become immune to being [culled|Perk+perk_rf_cull]")
		});
		return ret;
	}
});
