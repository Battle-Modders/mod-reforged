::mods_hookExactClass("entity/tactical/enemies/goblin_fighter_low", function(o) {
// 	o.onInit = function()
// 	{
// 	    // copy vanilla function contents completely
// 	    // and replace skills except equipment based skills
// 	    // NOTE: Remove the hook on onInit completely if unused
// 	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    this.goblin_fighter.assignRandomEquipment();
	}
});
