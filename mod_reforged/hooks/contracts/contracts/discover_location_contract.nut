::Reforged.HooksMod.hook("scripts/contracts/contracts/discover_location_contract", function(q) {
	q.RF_getOriginText = @(__original) { function RF_getOriginText()
	{
		if (::MSU.isNull(this.m.Location))
			return __original();

		local distance = this.getHome().getTile().getDistanceTo(this.m.Location.getTile());
		return format("%s %s %s of %s around the region of %s",
			this.m.Location.getName(),
			::Const.Strings.Distance[::Math.min(::Const.Strings.Distance.len() - 1, distance / 30.0 * (::Const.Strings.Distance.len() - 1))], // same equation as in the vanilla contract
			::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(this.m.Location.getTile())],
			::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome()),
			this.m.Flags.get("Region"));
	}}.RF_getOriginText;
});
