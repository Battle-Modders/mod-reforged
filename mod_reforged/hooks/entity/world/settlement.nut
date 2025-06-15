::Reforged.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.setOwner = @(__original) { function setOwner( _owner )
	{
		__original(_owner);
		this.adjustBannerOffset();
	}}.setOwner;

	q.setActive = @(__original) { function setActive( _a, _burn = true )
	{
		__original(_a, _burn);
		this.adjustBannerOffset();
	}}.setActive;

	q.onUpdateShopList = @(__original) { function onUpdateShopList( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
				if (this.getTile().SquareCoords.Y > ::World.getMapSize().Y * 0.7)
				{
					_list.extend([
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
					_list.extend([
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
				_list.extend([
					{
						R = 90,
						P = 1.0,
						S = "weapons/rf_reinforced_wooden_poleflail"
					}
				]);
				break;

			case "building.armorsmith":
				_list.extend([
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
				break;

			case "building.weaponsmith":
				_list.extend([
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
				break;

			case "building.weaponsmith_oriental":
				_list.extend([
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
				break;

			case "building.fletcher":
				_list.extend([
					{
						R = 10,
						P = 3.0,
						S = "tools/throwing_net"
					},
					{
						R = 20,
						P = 3.0,
						S = "tools/throwing_net"
					}
				]);
				break;
		}

		return __original(_id, _list);
	}}.onUpdateShopList;

	q.onEnter = @(__original) function()
	{
		local ret = __original();
		::World.Retinue.onPlayerEnterTown(this);
		return ret;
	}
});
