::mods_hookExactClass("entity/tactical/enemies/bandit_marksman_low", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		this.bandit_marksman.assignRandomEquipment();
	}
});
