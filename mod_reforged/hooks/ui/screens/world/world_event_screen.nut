::Reforged.HooksMod.hook("scripts/ui/screens/world/world_event_screen", function(q) {
	q.convertEventToUIData = @(__original) { function convertEventToUIData( _event )
	{
		local ret = __original(_event);
		// Add TooltipIDs for left and right characters shown on the screen.
		ret.characterLeftTooltipID <- _event.RF_getUICharacterTooltipID(0);
		ret.characterRightTooltipID <- _event.RF_getUICharacterTooltipID(1);
		return ret;
	}}.convertEventToUIData;
});
