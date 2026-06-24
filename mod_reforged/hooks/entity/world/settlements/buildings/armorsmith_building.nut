::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/armorsmith_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		ret.extend([
			{
				R = 80,
				P = 1.0,
				S = "armor/rf_reinforced_footman_armor"
			},
			{
				R = 80,
				P = 1.0,
				S = "armor/rf_breastplate"
			},
			{
				R = 80,
				P = 1.0,
				S = "armor/rf_brigandine_shirt"
			},
			{
				R = 85,
				P = 1.0,
				S = "armor/rf_brigandine_armor"
			},
			{
				R = 85,
				P = 1.0,
				S = "armor/rf_breastplate_armor"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/rf_skull_cap"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/rf_skull_cap_with_rondels"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/rf_padded_skull_cap"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/rf_sallet_helmet"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/rf_padded_skull_cap_with_rondels"
			},
			{
				R = 70,
				P = 1.0,
				S = "helmets/rf_padded_sallet_helmet"
			},
			{
				R = 70,
				P = 1.0,
				S = "helmets/rf_half_closed_sallet"
			},
			{
				R = 70,
				P = 1.0,
				S = "helmets/rf_skull_cap_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/rf_conical_billed_helmet"
			},
			{
				R = 80,
				P = 1.0,
				S = "helmets/rf_sallet_helmet_with_mail"
			},
			{
				R = 85,
				P = 1.0,
				S = "helmets/rf_padded_conical_billed_helmet"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
