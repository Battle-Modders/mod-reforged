::mods_hookExactClass("entity/tactical/player", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(::new("scripts/skills/actives/rf_adjust_dented_armor_ally_skill"));
	}
});
