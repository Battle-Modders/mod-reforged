::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	q.showRetreatScreen = @(__original) function ( _tag = null )
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
		return __original(_tag);
	}
});
