::Reforged.HooksMod.hook("scripts/contracts/contracts/decisive_battle_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("Against %s about %s %s of %s",
				::Reforged.NestedTooltips.getNestedFactionName(::World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse"))),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(this.RF_getTile(this.getHome()), this.m.WarcampTile) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[this.getHome().getDirection8To(this.m.WarcampTile)],
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;
});
