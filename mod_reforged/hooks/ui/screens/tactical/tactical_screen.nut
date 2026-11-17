::Reforged.HooksMod.hook("scripts/ui/screens/tactical/tactical_screen", function(q) {
	// Called from JS when a hit-chance overlay label is hovered or unhovered
	q.RF_onHitchanceLabelHovered <- { function RF_onHitchanceLabelHovered( _isHovered )
	{
		::Reforged.HitchanceOverlay.onLabelHovered(_isHovered);
	}}.RF_onHitchanceLabelHovered;
});
