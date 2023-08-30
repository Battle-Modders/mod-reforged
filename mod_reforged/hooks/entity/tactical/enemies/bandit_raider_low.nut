::mods_hookExactClass("entity/tactical/enemies/bandit_raider_low", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		this.bandit_raider.assignRandomEquipment();
	}
});
