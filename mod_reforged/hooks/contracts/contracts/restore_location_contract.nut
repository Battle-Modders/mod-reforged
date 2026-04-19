::Reforged.HooksMod.hook("scripts/contracts/contracts/restore_location_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("Ruined [%s|WorldEntity+%i] %s",
				this.m.Location.getRealName(),
				this.m.Location.getID(),
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "nearby" : "near " + ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;
});
