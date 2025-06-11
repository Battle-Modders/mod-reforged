::Reforged.HooksMod.hook("scripts/ui/screens/world/world_town_screen", function(q) {
	// Add support to show retinue from town
	q.onRetinueButtonPressed <- function()
	{
		::World.State.town_screen_main_dialog_module_onRetinueButtonClicked();
	}
});
