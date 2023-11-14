::Reforged.HooksMod.hook("scripts/events/events/dlc4/kings_guard_1_event", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local start = this.m.Screens[0].start;
		this.m.Screens[0].start = function( _event )
		{
			start(_event);
			_event.m.Dude.getPerkTree().removePerk("perk.rf_promised_potential");
		}
	}
});
