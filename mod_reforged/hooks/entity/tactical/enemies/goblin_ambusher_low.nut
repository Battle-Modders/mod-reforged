::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_ambusher_low", function(q) {
// 	q.onInit = @(__original) function()
// 	{
// 		// copy vanilla function contents completely
// 		// and replace skills except equipment based skills
// 		// NOTE: Remove the hook on onInit completely if unused
// 	}

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		this.goblin_ambusher.assignRandomEquipment();
	}}.assignRandomEquipment;
});
