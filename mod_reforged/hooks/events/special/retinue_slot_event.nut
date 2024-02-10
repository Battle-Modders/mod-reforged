::Reforged.HooksMod.hook("scripts/events/events/special/retinue_slot_event", function (q) {
	q.onUpdateScore = @() function()
	{
		return;		// This event no longer spawns naturally. Instead we fire it during the checkDesertion() check
	}
});
