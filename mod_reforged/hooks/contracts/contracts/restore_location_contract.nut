::Reforged.HooksMod.hook("scripts/contracts/contracts/restore_location_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("%s %s",
				::Reforged.NestedTooltips.getNestedWorldEntityName(this.m.Location),
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "nearby" : "near " + ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;
});
