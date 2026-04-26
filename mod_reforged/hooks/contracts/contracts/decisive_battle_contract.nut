::Reforged.HooksMod.hook("scripts/contracts/contracts/decisive_battle_contract", function(q) {
	q.RF_getOriginText = @() { function RF_getOriginText()
	{
		return ::Reforged.Mod.Tooltips.parseString(
			format("Against %s about %s %s of %s",
				::Reforged.NestedTooltips.getNestedFactionName(::World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse"))),
				::Reforged.Text.getDaysAndHalf(this.RF_getDaysRequiredToTravel(this.RF_getTile(this.getHome()), this.m.WarcampTile) * ::World.getTime().SecondsPerDay),
				::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(this.m.WarcampTile)],
				::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedWorldEntityName(this.getHome())
			)
		);
	}}.RF_getOriginText;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		// Vanilla calculates and sets m.WarcampTile during the `start()` function but
		// not serialize m.WarcampTile, so it becomes null after loading a save.
		// This doesn't cause any problems in vanilla because vanilla recalculates the
		// WarcampTile during the `end()` function of the `Offer` state. During that it sets
		// the `Warcamp` world entity which it does serialize.
		// But it causes issues in Reforged where we want to show the tooltip of the contract
		// and where we need the WarcampTile in the offer text before accepting the contract.
		if (!::MSU.isNull(this.m.WarcampTile))
		{
			this.m.Flags.set("RF_WarcampTileSquareCoords", format("%i,%i", this.m.WarcampTile.SquareCoords.X, this.m.WarcampTile.SquareCoords.Y));
		}
		__original(_out);
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);
		if (this.m.Flags.has("RF_WarcampTileSquareCoords"))
		{
			local coords = ::split(this.m.Flags.get("RF_WarcampTileSquareCoords"), ",");
			this.m.WarcampTile = ::World.getTileSquare(coords[0].tointeger(), coords[1].tointeger());
			this.m.Flags.remove("RF_WarcampTileSquareCoords");
		}
	}}.onDeserialize;
});
