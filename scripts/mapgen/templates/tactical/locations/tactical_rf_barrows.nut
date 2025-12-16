this.tactical_rf_barrows <- ::inherit("scripts/mapgen/tactical_template", {
	m = {},
	function init()
	{
		this.m.Name = "tactical.rf_barrows";
		this.m.MinX = 32;
		this.m.MinY = 32;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		local centerTile = ::Tactical.getTileSquare(_rect.W / 2 + _properties.ShiftX, _rect.H / 2 + _properties.ShiftY);
		local minDist = 0;
		local radius = ::Const.Tactical.Settings.CampRadius + _properties.AdditionalRadius;

		for (local x = _rect.X; x < _rect.X + _rect.W; x++)
		{
			for (local y = _rect.Y; y < _rect.Y + _rect.H; y++)
			{
				local tile = ::Tactical.getTileSquare(x, y);
				local d = centerTile.getDistanceTo(tile);

				if (d < minDist || d > radius)
					continue;

				if (::Math.rand(1, 100) <= 50)
				{
					tile.removeObject();
				}

				if (d < radius - 1 && tile.IsEmpty)
				{
					if (::Math.rand(1, 100) <= 2)
					{
						tile.clear();
						tile.spawnObject("entity/tactical/objects/rf_barrows_horns");
					}
					if (::Math.rand(1, 100) <= 6)
					{
						tile.clear();
						tile.spawnObject("entity/tactical/objects/rf_barrows_large");
					}
					else if (::Math.rand(1, 100) <= 10)
					{
						tile.clear();
						tile.spawnObject("entity/tactical/objects/rf_barrows");
					}
				}
			}
		}
	}
});
