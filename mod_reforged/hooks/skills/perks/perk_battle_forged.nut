::mods_hookExactClass("skills/perks/perk_battle_forged", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();

		this.m.IsEffectHiddenInTacticalTooltip = true;
	}
});
