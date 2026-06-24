::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_oriental_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		if (this.getSettlement().getTile().SquareCoords.Y > ::World.getMapSize().Y * 0.7)
		{
			ret.extend([
				{
					R = 70,
					P = 1.0,
					S = "accessory/warhound_item"
				},
				{
					R = 80,
					P = 1.0,
					S = "accessory/armored_warhound_item"
				}
			]);
		}
		else
		{
			ret.extend([
				{
					R = 70,
					P = 1.0,
					S = "accessory/wardog_item"
				},
				{
					R = 80,
					P = 1.0,
					S = "accessory/armored_wardog_item"
				}
			]);
		}

		ret.extend([
			{
				R = 90,
				P = 1.0,
				S = "weapons/rf_reinforced_wooden_poleflail"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
