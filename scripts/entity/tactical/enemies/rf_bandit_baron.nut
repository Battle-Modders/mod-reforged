this.rf_bandit_baron <- ::inherit("scripts/entity/tactical/human", {
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
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_leader_agent");
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_decisive"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_blitzkrieg"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.Cooldown = 3;
		}));
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
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && ::Math.rand(1, 100) <= 50)
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/shields/heater_shield"],
				[1.0, "scripts/items/shields/kite_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				local weapon = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/longsword"],
					[1, "scripts/items/weapons/rf_kriegsmesser"],
					[1, "scripts/items/weapons/rf_swordstaff"],
					[1, "scripts/items/weapons/two_handed_flail"],
					[1, "scripts/items/weapons/two_handed_flanged_mace"],
					[1, "scripts/items/weapons/greatsword"]
				]).roll();

				this.m.Items.equip(::new(weapon));
			}
			else
			{
				local weapon = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/fighting_axe"],
					[1, "scripts/items/weapons/military_cleaver"],
					[1, "scripts/items/weapons/fighting_spear"],
					[1, "scripts/items/weapons/noble_sword"],
					[1, "scripts/items/weapons/warhammer"],
					[1, "scripts/items/weapons/winged_mace"]
				]).roll();

				this.m.Items.equip(::new(weapon));
			}
		}

		if (this.m.IsMiniboss)
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/rf_brigandine_harness"],
					[1, "scripts/items/armor/rf_breastplate_armor"],
					[1, "scripts/items/armor/coat_of_plates"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_sallet_helmet_with_bevor"],
					[1, "scripts/items/helmets/rf_half_closed_sallet_with_mail"],
					[1, "scripts/items/helmets/rf_visored_bascinet"]
				]).roll()));
			}
		}
		else
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				local armor = ::Reforged.ItemTable.BanditArmorLeader.roll({
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 260 || conditionMax > 300) return 0.0;
						return _weight;
					}
				})
				if (armor != null) this.m.Items.equip(::new(armor))
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				local helmet = ::Reforged.ItemTable.BanditHelmetLeader.roll({
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 260 || conditionMax > 290) return 0.0;
						return _weight;
					}
				})
				if (helmet != null) this.m.Items.equip(::new(helmet));
			}
		}

		local bodyItem = this.getBodyItem();
		if (bodyItem != null && !bodyItem.isItemType(::Const.Items.ItemType.Named) && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier4)
		{
			local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
					if (conditionModifier > 40) return 0.0;
					return _weight;
				}
			});

			if (armorAttachment != null)
				bodyItem.setUpgrade(::new(armorAttachment));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 25)
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_axe"],
				[1, "scripts/items/weapons/named/named_cleaver"],
				[1, "scripts/items/weapons/named/named_spear"],
				[1, "scripts/items/weapons/named/named_sword"],
				[1, "scripts/items/weapons/named/named_hammer"],
				[1, "scripts/items/weapons/named/named_mace"],

				[1, "scripts/items/weapons/named/named_rf_longsword"],
				[1, "scripts/items/weapons/named/named_rf_kriegsmesser"],
				[1, "scripts/items/weapons/named/named_rf_swordstaff"],
				[1, "scripts/items/weapons/named/named_two_handed_flail"],
				[1, "scripts/items/weapons/named/named_two_handed_mace"],
				[1, "scripts/items/weapons/named/named_greatsword"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 45)
		{
			local shields = clone ::Const.Items.NamedShields;
			shields.extend([
				"shields/named/named_bandit_kite_shield",
				"shields/named/named_bandit_heater_shield"
			]);
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
			if (armor != null) this.m.Items.equip(::new(armor));
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
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		return true;
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver)) // Sword/Cleaver hybrid
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Spear)) // Sword/Spear hybrid
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_spear"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_king_of_all_weapons"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
				}
				else
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
				}
			}
			else
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			}

			if (::Reforged.Items.isDuelistValid(mainhandItem))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}
	}
});
