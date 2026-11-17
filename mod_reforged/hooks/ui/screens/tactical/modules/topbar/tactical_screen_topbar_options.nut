::Reforged.HooksMod.hook("scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_options", function(q) {
	q.changeFleeButtonToWin <- { function changeFleeButtonToWin()
	{
		this.m.JSHandle.asyncCall("changeFleeButtonToWin", null);
	}}.changeFleeButtonToWin;

	q.RF_onHitchanceDisplayButtonPressed <- { function RF_onHitchanceDisplayButtonPressed()
	{
		::Reforged.HitchanceOverlay.cycleMode();
	}}.RF_onHitchanceDisplayButtonPressed;

	q.RF_updateHitchanceDisplayButton <- { function RF_updateHitchanceDisplayButton()
	{
		if (this.m.JSHandle != null)
			this.m.JSHandle.asyncCall("RF_setHitchanceDisplayButtonState", ::Reforged.HitchanceOverlay.getMode());
	}}.RF_updateHitchanceDisplayButton;
});
