::Reforged.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.m.LastVisited <- -1;

	q.setOwner = @(__original) function( _owner )
	{
		__original(_owner);
		this.adjustBannerOffset();
	}

	q.setActive = @(__original) function( _a, _burn = true )
	{
		__original(_a, _burn);
		this.adjustBannerOffset();
	}

	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
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
						S = "armor/rf_brigandine_shirt"
					},
					{
						R = 85,
						P = 1.0,
						S = "armor/rf_brigandine_armor"
					},
					{
						R = 80,
						P = 1.0,
						S = "armor/rf_breastplate"
					},
					{
						R = 85,
						P = 1.0,
						S = "armor/rf_breastplate_armor"
					},
					{
						R = 80,
						P = 1.0,
						S = "armor/rf_reinforced_footman_armor"
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
						R = 80,
						P = 1.0,
						S = "weapons/rf_poleflail"
					},
					{
						R = 70,
						P = 1.0,
						S = "weapons/rf_reinforced_wooden_poleflail"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_swordstaff"
					}
				]);
				break;

			case "building.weaponsmith_oriental":
				_list.extend([
					{
						R = 85,
						P = 1.0,
						S = "weapons/rf_battle_axe"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_estoc"
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
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_swordstaff"
					}
				]);
				break;

			case "building.fletcher":
				_list.extend([
					{
						R = 10,
						P = 1.25,
						S = "tools/throwing_net"
					},
					{
						R = 20,
						P = 1.25,
						S = "tools/throwing_net"
					}
				]);
				break;
		}

		return __original(_id, _list);
	}

	q.onEnter = @(__original) function()
	{
		local ret = __original();
		this.m.LastVisited = ::World.getTime().Days;
		return ret;
	}

	q.onSerialize = @(__original) function( _out )
	{
		this.getFlags().set("rf_LastVisited", this.m.LastVisited);
		__original(_out);
	}

	q.onDeserialize = @(__original) function( _in )
	{
		__original(_in);
		if (this.getFlags().has("rf_LastVisited")) this.m.LastVisited = this.getFlags().get("rf_LastVisited");
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/icons/action_points.png",
			text = this.getLastVisitedString()
		});
		return ret;
	}

// New Functions
	q.getLastVisitedString <- function()
	{
		local ret = "Last visited: ";
		if (this.isVisited() == false) return ret + "never";
		if (this.m.LastVisited == -1) return ret + "unknown";	// This should only ever happen when loading old save games

		local dayDifference = ::World.getTime().Days - this.m.LastVisited;
		if (dayDifference == 0) return ret + "today";
		if (dayDifference == 1) return ret + "1 day ago";
		return ret + dayDifference + " days ago";
	}

	q.getLastVisited <- function()
	{
		return this.m.LastVisited;
	}
});
