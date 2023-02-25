::mods_hookExactClass("entity/world/settlements/buildings/tavern_building", function(o) {

	local getRumor = o.getRumor;
	o.getRumor = function( _isPaidFor = false )
	{
		local lastRumor = this.m.LastRumor;
		local ret = getRumor(_isPaidFor);
		if (this.m.RumorsGiven > 3) return ret;
		if (ret == null) return ret;
		if (ret == lastRumor) return ret;

		// Very hard-coded way to slot this rumor alongside the existing ones
		local r = ::World.Assets.m.IsNonFlavorRumorsOnly ? ::Math.rand(1, 5) : ::Math.rand(1, 7);
		if (r != 1) return ret;

		local bestLocation = this.getLegendaryLocationForRumor();
		if (bestLocation == null) return ret;	// This should only happen if all legendary locations on the map are discovered

		this.m.Location = ::WeakTableRef(bestLocation);
		local candidates = ::Const.Strings.RumorsUniqueLocation[::Math.rand(0, 1)];     // 50% of the time you get a generic tip with no name of the location

		local rumor = "";
		if (_isPaidFor) rumor = ::MSU.Array.rand(::Const.Strings.PayTavernRumorsIntro);
		else  rumor = "The patrons talk about this and that.";

		rumor += "\n\n[color=#bcad8c]\"";
		rumor += ::MSU.Array.rand(candidates);
		rumor += "\"[/color]\n\n";
		rumor = this.buildText(rumor);
		this.m.LastRumor = rumor;

		return rumor;
	}

	o.getLegendaryLocationForRumor <- function()
	{
		local bestLocation = null;
		local bestDist = 9000;

		foreach( s in ::World.EntityManager.getLocations() )
		{
			if (s.isLocationType(::Const.World.LocationType.Unique) == false) continue;
			if (s.isDiscovered()) continue;     // We don't want to show the player already discovered unique locations
			if (s.getVisibilityMult() == 0.0) continue;     // These legendary locations are not meant to be found yet (tundra_elk_location)

			local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - ::Math.rand(1, 10);  // Small variance so we don't always talk about the nearest unique location
			if (d > bestDist) continue;

			bestDist = d;
			bestLocation = s;
		}
		return bestLocation;
	}
});
