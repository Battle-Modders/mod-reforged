::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/vampire_low", function(q) {
// 	q.onInit = @(__original) function()
// 	{
// 	    // copy vanilla function contents completely
// 	    // and replace skills except equipment based skills
// 	    // NOTE: Remove the hook on onInit completely if unused
// 	}

	q.assignRandomEquipment = @(__original) function()
	{
	    this.vampire.assignRandomEquipment();
	}
});
