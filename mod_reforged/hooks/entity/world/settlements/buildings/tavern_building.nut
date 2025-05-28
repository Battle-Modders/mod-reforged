::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/tavern_building", function(q) {

	q.getRumor = @(__original) { function getRumor( _isPaidFor = false )
	{
		local lastRumor = this.m.LastRumor;
		local ret = __original(_isPaidFor);
		if (this.m.RumorsGiven > 3) return ret;
		if (ret == null) return ret;
		if (ret == lastRumor) return ret;

		// Very hard-coded way to slot this rumor alongside the existing ones
		local r = ::World.Assets.m.IsNonFlavorRumorsOnly ? ::Math.rand(1, 5) : ::Math.rand(1, 7);
		if (r != 1) return ret;

		local bestLocation = this.getLegendaryLocationForRumor();
		if (bestLocation == null) return ret;	// This should only happen if all legendary locations on the map are discovered

		this.m.Location = ::WeakTableRef(bestLocation);
		local candidates = ::Const.Strings.RumorsUniqueLocation[::Math.rand(0, 1)];	 // 50% of the time you get a generic tip with no name of the location

		local rumor = "";
		if (_isPaidFor) rumor = ::MSU.Array.rand(::Const.Strings.PayTavernRumorsIntro);
		else  rumor = "The patrons talk about this and that.";

		rumor += "\n\n[color=#bcad8c]\"";
		rumor += ::MSU.Array.rand(candidates);
		rumor += "\"[/color]\n\n";
		rumor = this.buildText(rumor);
		this.m.LastRumor = rumor;

		return rumor;
	}}.getRumor;

	q.buildText = @(__original) { function buildText( _text )
	{
		// Switcheroo so that we only change the global 'buildTextFromTemplate' when used by the Tavern Building
		local buildTextFromTemplate = ::buildTextFromTemplate;
		::buildTextFromTemplate = function( _text, _vars )
		{
			this.adjustVars(_vars);
			return buildTextFromTemplate(_text, _vars);
		}

		local ret = __original(_text);

		::buildTextFromTemplate = buildTextFromTemplate;

		return ret;
	}}.buildText;

// New Functions
	q.getLegendaryLocationForRumor <- { function getLegendaryLocationForRumor()
	{
		local bestLocation = null;
		local bestDist = 9000;

		foreach( s in ::World.EntityManager.getLocations() )
		{
			if (s.isLocationType(::Const.World.LocationType.Unique) == false) continue;
			if (s.isDiscovered()) continue;	 // We don't want to show the player already discovered unique locations
			if (s.getVisibilityMult() == 0.0) continue;	 // These legendary locations are not meant to be found yet (tundra_elk_location)

			local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - ::Math.rand(1, 10);  // Small variance so we don't always talk about the nearest unique location
			if (d > bestDist) continue;

			bestDist = d;
			bestLocation = s;
		}
		return bestLocation;
	}}.getLegendaryLocationForRumor;

	// We add up 4 new variables for texts to be build with.
	// Three are wrong distances, direction and terrain for the purpose of creating more interesting rumors.
	// One is an indirect adjective for a legendary location if you don't wanna name it directly
	q.adjustVars <- { function adjustVars( _vars )
	{
		foreach (var in _vars)
		{
			if (var[0] == "distance")
			{
				local wrongDistances = ::Const.Strings.Distance.filter(@(_idx, _val) _val != var[1]);
				_vars.push([
					"wrongDistance",
					::MSU.Array.rand(wrongDistances)
				]);
			}
			else if (var[0] == "direction")
			{
				local wrongDirections = ::Const.Strings.Direction8.filter(@(_idx, _val) _val != var[1]);
				_vars.push([
					"wrongDirection",
					::MSU.Array.rand(wrongDirections)
				]);
			}
			else if (var[0] == "terrain")
			{
				local wrongTerrains = ::Const.Strings.Terrain.filter(@(_idx, _val) (_val != var[1] && _val != ""));
				_vars.push([
					"wrongTerrain",
					::MSU.Array.rand(wrongTerrains)
				]);
			}
		}
		_vars.push([
			"legendaryLocationAdjective",
			::MSU.Array.rand(::Const.Strings.LegendaryLocationAdjective)
		])
	}}.adjustVars;
});
