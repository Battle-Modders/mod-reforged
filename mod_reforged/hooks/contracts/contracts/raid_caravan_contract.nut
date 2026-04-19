::Reforged.HooksMod.hook("scripts/contracts/contracts/raid_caravan_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		local interceptStart = ::World.getEntityByID(this.m.Flags.get("InterceptStart"));
		local interceptDest = ::World.getEntityByID(this.m.Flags.get("InterceptDest"));

		return ::Reforged.Mod.Tooltips.parseString(
			format("Of %s that is going from %s about %s %s of %s to %s about %s %s from there",
				::Reforged.NestedTooltips.getNestedFactionName(::World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse"))),
				::Reforged.NestedTooltips.getNestedWorldEntityName(interceptStart),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(this.getHome().getTile(), interceptStart.getTile()) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(interceptStart.getTile())],
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome()),
				::Reforged.NestedTooltips.getNestedWorldEntityName(interceptDest),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(interceptStart.getTile(), interceptDest.getTile()) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[interceptStart.getTile().getDirection8To(interceptDest.getTile())]
			)
		);
	}}.RF_getOriginText;
});
