::Reforged.HooksMod.hook("scripts/contracts/contracts/siege_fortification_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("Against %s at %s about %s %s of %s",
				::Reforged.NestedTooltips.getNestedFactionName(::World.FactionManager.getFaction(this.m.Flags.get("RivalHouseID"))),
				::Reforged.NestedTooltips.getNestedWorldEntityName(this.getOrigin()),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(this.getHome().getTile(), this.getOrigin().getTile()) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(this.getOrigin().getTile())],
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;
});
