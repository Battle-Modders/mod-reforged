::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_marksman_low", function(q) {
	q.assignRandomEquipment = @(__original) function()
	{
		this.bandit_marksman.__original();
	}
});
