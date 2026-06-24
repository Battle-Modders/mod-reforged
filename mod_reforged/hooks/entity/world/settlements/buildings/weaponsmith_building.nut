::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		ret.extend([
			{
				R = 50,
				P = 1.0,
				S = "weapons/rf_two_handed_falchion"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/rf_kriegsmesser"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/rf_greatsword"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/rf_voulge"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/rf_reinforced_wooden_poleflail"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_battle_axe"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_estoc"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_poleflail"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_swordstaff"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_halberd"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/rf_poleaxe"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
