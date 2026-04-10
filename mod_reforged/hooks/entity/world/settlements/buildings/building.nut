::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/building", function(q) {
	q.RF_getTooltip <- { function RF_getTooltip()
	{
		return ::TooltipEvents.general_queryUIElementTooltipData(null, this.m.Tooltip, null);
	}}.RF_getTooltip;
});
