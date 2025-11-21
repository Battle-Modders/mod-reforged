::Reforged.HooksMod.hook("scripts/events/event_manager", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.addSpecialEvent("event.rf_oathtakers_take_oaths_in_regular_origins");
	}}.create;
});
