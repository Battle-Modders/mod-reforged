::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_raider_low", function(q) {
	q.assignRandomEquipment = @(__original) function()
	{
		this.bandit_raider.assignRandomEquipment();
	}
});
