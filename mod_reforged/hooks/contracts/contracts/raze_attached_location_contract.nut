::Reforged.HooksMod.hook("scripts/contracts/contracts/raze_attached_location_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("%s near %s about %s %s of %s",
				::Reforged.NestedTooltips.getNestedWorldEntityName(this.m.Destination),
				::Reforged.NestedTooltips.getNestedWorldEntityName(this.m.Settlement),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(this.getHome().getTile(), this.m.Settlement.getTile()) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(this.m.Destination.getTile())],
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;
});
