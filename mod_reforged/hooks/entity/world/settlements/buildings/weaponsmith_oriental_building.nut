::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		ret.extend([
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_swordstaff"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_estoc"
			},
			{
				R = 85,
				P = 1.0,
				S = "weapons/rf_battle_axe"
			},
			{
				R = 85,
				P = 1.0,
				S = "weapons/rf_greatsword"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/rf_reinforced_wooden_poleflail"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
