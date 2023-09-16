this.rf_bandit_bandit <- this.inherit("scripts/entity/tactical/human", {
	m = {
		MyVariant = 0 // 1 for regular throwing weapons, 0 for not or throwing spear.
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditBandit;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditBandit.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bandits/rf_bandit_fast_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditBandit);
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

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_momentum"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hybridization"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));

		this.m.MyVariant = ::Math.rand(0, 1); // 1 is thrower
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (::Math.rand(1, 100) < 20 && (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)))
		{
			this.m.Items.equip(::new("scripts/items/tools/throwing_net"))
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (this.m.MyVariant == 0) // Not regular throwing weapons
			{
				local throwing = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/throwing_spear"]
				]).rollChance(25);

				if (throwing != null) this.m.Items.equip(::new(throwing));
			}
			else // Thrower
			{
				local throwing = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/javelin"],
					[1, "scripts/items/weapons/throwing_axe"]
				]).roll();

				this.m.Items.equip(::new(throwing));
			}
		}

		local weapon = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/boar_spear"],
			[1, "scripts/items/weapons/rondel_dagger"],
			[1, "scripts/items/weapons/arming_sword"],
			[1, "scripts/items/weapons/scramasax"],

			[1, "scripts/items/weapons/billhook"],
			[1, "scripts/items/weapons/longsword"],
			[1, "scripts/items/weapons/rf_poleflail"],
			[1, "scripts/items/weapons/pike"],
			[1, "scripts/items/weapons/spetum"],
			[1, "scripts/items/weapons/warbrand"]
		]).roll();

		weapon = ::new(weapon);
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)) // both hands free
		{
			this.m.Items.equip(weapon);
		}
		else if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && weapon.isItemType(::Const.Items.ItemType.OneHanded)) // mainhand free and rolled 1h melee weapon
		{
			this.m.Items.equip(weapon);
		}
		else // cannot equip melee weapon to hands
		{
			this.m.Items.addToBag(weapon);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Exclude = [
					"scripts/items/armor/patched_mail_shirt"
				],
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 65 || conditionMax > 130) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Exclude = [
					"scripts/items/helmets/dented_nasal_helmet"
				],
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 80 || conditionMax > 130) return 0.0;
					if (conditionMax > 125 || conditionMax <= 130) return _weight * 0.5;
					return _weight;
				},
				Add = [
					[1.0, "scripts/items/helmets/closed_mail_coif"],
					[0.25, "scripts/items/helmets/nordic_helmet"]
				]
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local offhand = this.getOffhandItem();
		if (offhand != null && offhand.isItemType(::Const.Items.ItemType.Tool)) //rolled throwing net
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_angler"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isItemType(::Const.Items.ItemType.MeleeWeapon)) //melee weapon equipped and not in bag
			{
				if (weapon.isItemType(::Const.Items.ItemType.OneHanded)) //melee weapon equipped and one handed
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))
					{
						::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
					}
					else if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
					{
						::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
						this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sneak_attack"));
						this.m.Skills.add(::new("scripts/skills/perks/rf_swift_stabs"));
					}
					else //sword or cleaver
					{
						::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
					}
				}
				else //melee weapon equipped and two handed
				{
					if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))
					{
						::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					}
					else if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))
					{
						::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 7);
					}
					else
					{
						switch (weapon.getID())
						{
							case "weapon.billhook":
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
								break;
							case "weapon.longsword":
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_kata"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
								break;
							case "weapon.pike":
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
								break;
							case "weapon.warbrand":
								::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
								this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
								break;
						}
					}
				}
			}
		}

		foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag))  //primary weapon in bag and not equipped
		{
			if (item.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				if (item.isItemType(::Const.Items.ItemType.OneHanded)) //one handed
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					if (item.isWeaponType(::Const.Items.WeaponType.Spear))
					{
						::Reforged.Skills.addPerkGroupOfWeapon(this, item, 6);
					}
					else if (item.isWeaponType(::Const.Items.WeaponType.Dagger))
					{
						::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
						this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sneak_attack"));
					}
					else //Sword or Cleaver
					{
						::Reforged.Skills.addPerkGroupOfWeapon(this, item, 5);
					}
				}
				else //two handed
				{
					if (item.isWeaponType(::Const.Items.WeaponType.Flail))
					{
						::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					}
					else if (item.isWeaponType(::Const.Items.WeaponType.Spear))
					{
						::Reforged.Skills.addPerkGroupOfWeapon(this, item, 7);
					}
					else
					{
						switch (item.getID())
						{
							case "weapon.billhook":
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
								break;
							case "weapon.longsword":
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_kata"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
								break;
							case "weapon.pike":
								this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
								break;
							case "weapon.warbrand":
								::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
								this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
								this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
								break;
						}
					}
				}
			}
		}
	}
});

