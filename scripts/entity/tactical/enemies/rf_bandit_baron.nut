this.rf_bandit_baron <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditBaron;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditBaron.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				::Const.World.LocationNames.VillageWestern[::Math.rand(0, ::Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(::Const.Strings.BanditLeaderNames[::Math.rand(0, ::Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditBaron);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_blitzkrieg"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.getSprite("armor").setBrightness(0.9);
		this.getSprite("helmet").setBrightness(0.9);
		this.getSprite("helmet_damage").setBrightness(0.9);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/military_cleaver"],
				[1, "scripts/items/weapons/fighting_spear"],
				[1, "scripts/items/weapons/noble_sword"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"],

				[1, "scripts/items/weapons/rf_kriegsmesser"],
				[1, "scripts/items/weapons/rf_swordstaff"],
				[1, "scripts/items/weapons/two_handed_flail"],
				[1, "scripts/items/weapons/two_handed_flanged_mace"],
				[1, "scripts/items/weapons/greatsword"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/shields/heater_shield"],
				[1.0, "scripts/items/shields/kite_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorLeader.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 280 || conditionMax > 340) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}


		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetLeader.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 290 || conditionMax > 330) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local shields = clone ::Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);

		local r = ::Math.rand(1, 100);
		if (r <= 25)
		{
			this.m.Items.equip(::new("scripts/items/" + ::Const.Items.NamedMeleeWeapons[::Math.rand(0, ::Const.Items.NamedMeleeWeapons.len() - 1)]));
		}
		else if (r <= 45)
		{
			this.m.Items.equip(::new("scripts/items/" + shields[::Math.rand(0, shields.len() - 1)]));
		}
		else if (r <= 75)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 280) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}
		else
		{
			local helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 265 || conditionMax > 290) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		return true;
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_splitter"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this)
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Spear))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this)
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
				}
			}
			else //Two Handed Weapon
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_whirling_death"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_flail_spinner"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
				}
				else
				{
					switch (mainhandItem.getID())
					{
						case "weapon.rf_kriegsmesser":
							this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
							break;
						case "weapon.rf_swordstaff":
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_two_for_one"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_king_of_all_weapons"));
							break;
						case "weapon.greatsword":
							this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_kata"));
							this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
						break;
					}
				}
			}
		}

		local attack = this.getSkills().getAttackOfOpportunity();
		if (attack != null && attack.getBaseValue("ActionPointCost") <= 4)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		}

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_line_breaker"));
		}
	}

});

