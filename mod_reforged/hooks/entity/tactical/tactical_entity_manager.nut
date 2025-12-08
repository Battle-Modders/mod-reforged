::Reforged.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function(q) {
	// Increase LastIdleTime based on VirtualTimeSpeed so that combat speed mods
	// don't make idle sounds trigger more often at faster combat speeds.
	q.update = @(__original) { function update()
	{
		local old_LastIdleSound = this.m.LastIdleSound;

		__original();

		// We multiply LastIdleSound with the virtual time speed. This is not as
		// "accurate" as adjusting the Const.IdleSoundMinDelay and similar variables
		// but is safer as we avoid switcherooing Const values which can be problematic
		// if an exception occurs during __original().
		if (this.m.LastIdleSound != old_LastIdleSound)
		{
			this.m.LastIdleSound *= ::Time.getVirtualSpeed();
		}
	}}.update;
});
