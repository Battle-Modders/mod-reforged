::Reforged.HooksMod.hook("scripts/ui/screens/tactical/modules/orientation_overlay/orientation_overlay", function(q) {
	// Vanilla calls this every frame during combat. We use it to drive the hit-chance overlay.
	// Our work runs after __original because vanilla may asyncCall "disableOverlays" in it.
	q.update = @(__original) { function update()
	{
		__original();
		::Reforged.HitchanceOverlay.onFrame();
	}}.update;
});
