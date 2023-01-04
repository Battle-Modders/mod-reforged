::mods_hookExactClass("entity/tactical/enemies/zombie_nomad", function(o) {
	o.onInit = function()
	{
	    // copy vanilla function contents completely
	    // and replace skills except equipment based skills
	    // NOTE: Remove the hook on onInit completely if unused
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    // any skills that should be added based on equipment
	}
});
