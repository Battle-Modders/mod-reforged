::Reforged.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.m.RF_LastVisitSituations <- [];
	q.m.RF_LastVisitContracts <- [];

	q.RF_clearLastVisitInfo <- { function RF_clearLastVisitInfo()
	{
		this.getFlags().remove("RF_LastVisitDay");
		this.m.RF_LastVisitContracts.clear();
		this.m.RF_LastVisitSituations.clear();
		foreach (s in this.getSituations())
		{
			s.m.RF_LastVisitContracts.clear();
		}
	}}.RF_clearLastVisitInfo;

	q.RF_saveLastVisitInfo <- { function RF_saveLastVisitInfo()
	{
		this.getFlags().set("RF_LastVisitDay", ::World.getTime().Days);
		this.m.RF_LastVisitSituations = clone this.getSituations();

		foreach (c in this.getContracts())
		{
			this.m.RF_LastVisitContracts.push(c);
			if (c.m.SituationID == null)
				continue;

			foreach (s in this.m.RF_LastVisitSituations)
			{
				if (s.getInstanceID() == c.m.SituationID)
				{
					s.m.RF_LastVisitContracts.push(::MSU.asWeakTableRef(c));
					break;
				}
			}
		}

		::World.Contracts.m.RF_LastVisitContracts[this.getName()] <- this.m.RF_LastVisitContracts;
	}}.RF_saveLastVisitInfo;

	q.onEnter = @(__original) { function onEnter()
	{
		local ret = __original();
		// If ret is true that means we successfully entered the settlement.
		if (ret)
		{
			this.RF_clearLastVisitInfo();

			// Start all contracts present in this settlement.
			// Starting the contract sets up its origin/home/payment/destination etc.
			foreach (c in this.getContracts())
			{
				if (!c.isStarted())
					c.start();
			}
		}
		return ret;
	}}.onEnter;

	q.onLeave = @(__original) { function onLeave()
	{
		__original();
		this.RF_saveLastVisitInfo();
	}}.onLeave;

	// Add character image to the UI information for the character offering this contract.
	q.getUIContractInformation = @(__original) { function getUIContractInformation()
	{
		local ret = __original();
		foreach (c in ret.Contracts)
		{
			foreach (contract in this.getContracts())
			{
				if (contract.getID() == c.ID)
				{
					c.CharacterImagePath <- contract.getCharacter().getImagePath();
					break;
				}
			}
		}
		return ret;
	}}.getUIContractInformation;

	// Add character image to the UI information for the character offering this contract.
	q.getUIInformation = @(__original) { function getUIInformation()
	{
		local ret = __original();
		foreach (c in ret.Contracts)
		{
			foreach (contract in this.getContracts())
			{
				if (contract.getID() == c.ID)
				{
					c.CharacterImagePath <- contract.getCharacter().getImagePath();
					break;
				}
			}
		}
		return ret;
	}}.getUIInformation;

	q.RF_getLastVisitInfoTooltip <- { function RF_getLastVisitInfoTooltip()
	{
		if (!this.getFlags().has("RF_LastVisitDay"))
			return [];

		local entry = {
			id = 10, type = "hint", icon = "ui/icons/action_points.png",
			text = format("You were there %s", ::Reforged.Text.getDaysAgoAsText(::World.getTime().Days - this.getFlags().get("RF_LastVisitDay")))
		};

		if (this.RF_isShowingLastVisitInfo())
		{
			local list = this.RF_getLastVisitSituationsTooltip();
			list.extend(this.RF_getLastVisitContractsTooltip())

			if (list.len() != 0)
			{
				entry.text += " and noticed";
				entry.children <- list;
			}
		}

		return [entry];
	}}.RF_getLastVisitInfoTooltip;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.extend(this.RF_getLastVisitInfoTooltip());

		// Convert situations and contracts to nested tooltips
		// e.g. the ones added by Agent follower.
		local contractNames = this.getContracts().map(@(_c) _c.getName());
		local situationNames = this.getSituations().map(@(_s) _s.getName());
		// Convert building names to nested tooltips.
		local buildingNames = this.m.Buildings.map(@(_b) _b == null ? null : _b.getName());
		foreach (entry in ret)
		{
			local idx = contractNames.find(entry.text);
			if (idx != null)
			{
				local c = this.getContracts()[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(c, "func:RF_getTooltip,contentType:settlement-status-effect"));
				continue;
			}
			idx = situationNames.find(entry.text);
			if (idx != null)
			{
				local s = this.getSituations()[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(s, "contentType:settlement-status-effect"))
				continue;
			}
			idx = buildingNames.find(entry.text);
			if (idx != null)
			{
				local b = this.m.Buildings[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(b, "func:RF_getTooltip,contentType:settlement-status-effect"))
			}
		}
		return ret;
	}}.getTooltip;

	q.RF_isShowingLastVisitInfo <- { function RF_isShowingLastVisitInfo()
	{
		return !::World.Retinue.hasFollower("follower.agent");
	}}.RF_isShowingLastVisitInfo;

	q.RF_getLastVisitSituationsTooltip <- { function RF_getLastVisitSituationsTooltip()
	{
		local ret = [];
		local addedSituations = [];
		foreach (s in this.m.RF_LastVisitSituations)
		{
			if (addedSituations.find(s.getName()) != null)
				continue;

			addedSituations.push(s.getName());
			ret.push({
				id = 100, type = "text", icon = s.getIcon(),
				text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(s, "contentType:settlement-status-effect"))
			});
		}
		return ret;
	}}.RF_getLastVisitSituationsTooltip;

	q.RF_getLastVisitContractsTooltip <- { function RF_getLastVisitContractsTooltip()
	{
		return this.m.RF_LastVisitContracts.map(@(_c) {
			id = 200, type = "text", icon = _c.RF_getTooltipIcon(),
			text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(_c, "func:RF_getTooltip,contentType:settlement-status-effect"))
		});
	}}.RF_getLastVisitContractsTooltip;

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

			case "building.alchemist":
				_list.extend([
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
				break;
		}

		return __original(_id, _list);
	}}.onUpdateShopList;

	q.addSituation = @(__original) { function addSituation( _s, _validForDays = 0 )
	{
		__original(_s, _validForDays);
		_s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
	}}.addSituation;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		__original(_out);

		_out.writeU8(this.m.RF_LastVisitSituations.len());
		foreach (s in this.m.RF_LastVisitSituations)
		{
			_out.writeI32(s.ClassNameHash);
			s.onSerialize(_out);
		}
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);

		foreach (s in this.getSituations())
		{
			s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
		}

		if (::Reforged.Mod.Serialization.isSavedVersionAtLeast("0.8.5", _in.getMetaData()))
		{
			local count = _in.readU8();
			this.m.RF_LastVisitSituations = array(count);
			for (local i = 0; i < count; i++)
			{
				local s = ::new(::IO.scriptFilenameByHash(_in.readI32()));
				s.onDeserialize(_in);
				this.m.RF_LastVisitSituations[i] = s;
				s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
			}
		}
	}}.onDeserialize;
});
