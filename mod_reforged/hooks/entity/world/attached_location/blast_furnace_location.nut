::Reforged.HooksMod.hook("scripts/entity/world/attached_location/blast_furnace_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		switch (_id)
		{
			case "building.armorsmith":
				if (!this.getSettlement().isSouthern())
				{
					_list.extend([
						{
							R = 50,
							P = 1.0,
							S = "armor/rf_brigandine_shirt"
						},
						{
							R = 55,
							P = 1.0,
							S = "armor/rf_brigandine_armor"
						},
						{
							R = 60,
							P = 1.0,
							S = "armor/rf_brigandine_harness"
						},
						{
							R = 50,
							P = 1.0,
							S = "armor/rf_breastplate"
						},
						{
							R = 55,
							P = 1.0,
							S = "armor/rf_breastplate_armor"
						},
						{
							R = 60,
							P = 1.0,
							S = "armor/rf_breastplate_harness"
						},
						{
							R = 50,
							P = 1.0,
							S = "armor/rf_reinforced_footman_armor"
						},
						{
							R = 70,
							P = 1.0,
							S = "armor/rf_kastenbrust_plate_harness"
						},
						{
							R = 70,
							P = 1.0,
							S = "armor/rf_foreign_plate_harness"
						},
						{
							R = 70,
							P = 1.0,
							S = "armor/rf_heavy_plate_harness"
						},
						{
							R = 40,
							P = 1.0,
							S = "helmets/rf_skull_cap"
						},
						{
							R = 40,
							P = 1.0,
							S = "helmets/rf_skull_cap_with_rondels"
						},
						{
							R = 50,
							P = 1.0,
							S = "helmets/rf_padded_skull_cap"
						},
						{
							R = 50,
							P = 1.0,
							S = "helmets/rf_sallet_helmet"
						},
						{
							R = 50,
							P = 1.0,
							S = "helmets/rf_padded_skull_cap_with_rondels"
						},
						{
							R = 60,
							P = 1.0,
							S = "helmets/rf_padded_sallet_helmet"
						},
						{
							R = 60,
							P = 1.0,
							S = "helmets/rf_half_closed_sallet"
						},
						{
							R = 60,
							P = 1.0,
							S = "helmets/rf_skull_cap_with_mail"
						},
						{
							R = 60,
							P = 1.0,
							S = "helmets/rf_closed_bascinet"
						},
						{
							R = 70,
							P = 1.0,
							S = "helmets/rf_conical_billed_helmet"
						},
						{
							R = 70,
							P = 1.0,
							S = "helmets/rf_sallet_helmet_with_mail"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_padded_conical_billed_helmet"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_sallet_helmet_with_bevor"
						},
						{
							R = 70,
							P = 1.0,
							S = "helmets/rf_half_closed_sallet_with_mail"
						},
						{
							R = 75,
							P = 1.0,
							S = "helmets/rf_visored_bascinet"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_half_closed_sallet_with_bevor"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_snubnose_bascinet_with_mail"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_hounskull_bascinet_with_mail"
						},
						{
							R = 80,
							P = 1.0,
							S = "helmets/rf_great_helm"
						}
					]);
				}
				break;
		}

		return __original(_id, _list);
	}
});
