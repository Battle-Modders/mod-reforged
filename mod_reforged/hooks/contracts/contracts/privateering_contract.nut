::Reforged.HooksMod.hook("scripts/contracts/contracts/privateering_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(format("Against %s", ::Reforged.NestedTooltips.getNestedFactionName(::World.FactionManager.getFaction(this.m.Flags.get("FeudingHouseID")))));
	}}.RF_getOriginText;
});
