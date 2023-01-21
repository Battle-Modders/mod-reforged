::mods_hookExactClass("skills/perks/perk_battle_flow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "ui/perks/rf_battle_flow.png"
	}
});
