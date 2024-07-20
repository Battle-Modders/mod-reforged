::Reforged.HooksMod.hook("scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_options", function(q) {
	q.changeFleeButtonToWin <- function()
	{
		this.m.JSHandle.asyncCall("changeFleeButtonToWin", null);
	}
});
