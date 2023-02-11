::mods_hookExactClass("entity/tactical/enemies/orc_young_low", function(o) {
// 	o.onInit = function()
// 	{
// 	    // copy vanilla function contents completely
// 	    // and replace skills except equipment based skills
// 	    // NOTE: Remove the hook on onInit completely if unused
// 	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    this.orc_young.assignRandomEquipment();
	}
});
