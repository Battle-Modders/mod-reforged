::mods_hookExactClass("states/tactical_state", function(o)
{
    local showRetreatScreen = o.showRetreatScreen
    o.showRetreatScreen = function ( _tag = null )
    {
        this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToAllowRetreat(true);
        showRetreatScreen();
    }
});
