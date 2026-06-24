::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		ret.extend([
			{
				R = 40,
				P = 1.0,
				S = "accessory/rf_dodge_potion_item"
			},
			{
				R = 40,
				P = 1.0,
				S = "accessory/rf_warmth_potion_item"
			},
			// For bombs we use same R and P as vanilla bombs
			// in alchemist. We add 2 bombs as vanilla.
			{
				R = 10,
				P = 1.0,
				S = "tools/rf_grave_chill_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/rf_grave_chill_bomb_item"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
