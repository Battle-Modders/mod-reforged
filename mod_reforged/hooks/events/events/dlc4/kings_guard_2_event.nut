::Reforged.HooksMod.hook("scripts/events/events/dlc4/kings_guard_2_event", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local start = this.m.Screens[0].start;
		this.m.Screens[0].start = function( _event )
		{
			start(_event);
			local kingsguard_perkTree = ::new("scripts/skills/backgrounds/kings_guard_background").createPerkTreeBlueprint();
			kingsguard_perkTree.setActor(_event.m.Dude);
			kingsguard_perkTree.build();
			_event.m.Dude.getPerkTree().merge(kingsguard_perkTree);
			_event.m.Dude.resetPerks();
		}
	}
});
