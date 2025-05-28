::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_raider_low", function(q) {
	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		this.bandit_raider.assignRandomEquipment();
	}}.assignRandomEquipment;
});
