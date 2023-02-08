::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_options", function(o) {
    o.changeFleeButtonToWin <- function()
    {
        this.m.JSHandle.asyncCall("changeFleeButtonToWin");
    }
});
