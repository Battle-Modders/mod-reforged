::Reforged.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.getFollowerFromSlot <- function(_idx)
	{
		return this.m.Slots[_idx];
	}
})

