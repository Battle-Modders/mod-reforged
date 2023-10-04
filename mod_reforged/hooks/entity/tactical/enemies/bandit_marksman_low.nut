::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_marksman_low", function(q) {
	q.assignRandomEquipment = @() function()
	{
		this.bandit_marksman.assignRandomEquipment();
	}
});
