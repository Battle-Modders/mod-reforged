this.rf_bandit_robber <- this.inherit("scripts/entity/tactical/human", {
	m = {
		MyVariant = 0
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditRobber;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditRobber.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditRobber);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hybridization"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));

		this.m.MyVariant = ::Math.rand(0, 1); // 1 is Thrower
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (::Math.rand (1, 100) < 20 && (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)))
		{
			this.m.Items.equip(::new("scripts/items/tools/throwing_net"))
		}

		if (this.m.MyVariant == 1) // Thrower
        {
			local throwingWeapon = ::MSU.Class.WeightedContainer([
	    		[1, "scripts/items/weapons/javelin"],
				[1, "scripts/items/weapons/throwing_axe"]
	    	]).roll();

	    	this.m.Items.equip(::new(throwingWeapon));
        }

		local weapon = ::MSU.Class.WeightedContainer([
    		[1, "scripts/items/weapons/boar_spear"],
			[1, "scripts/items/weapons/dagger"],
			[1, "scripts/items/weapons/falchion"],
			[1, "scripts/items/weapons/scramasax"],

			[1, "scripts/items/weapons/hooked_blade"],
			[1, "scripts/items/weapons/pike"],
			[1, "scripts/items/weapons/reinforced_wooden_flail"],
			[1, "scripts/items/weapons/warfork"]
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
		else  // cannot equip melee weapon to hands
		{
			this.m.Items.addToBag(weapon);
		}

		if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[0.5, "scripts/items/shields/buckler_shield"],
				[0.5, "scripts/items/shields/wooden_shield"]
			]).rollChance(33);

			if (shield != null)
			{
				if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && !this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand))
				{
					this.m.Items.equip(::new(shield));
				}
				else
				{
					this.m.Items.addToBag(::new(shield));
				}
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 35 || conditionMax > 105) return 0.0;
					if (conditionMax > 95 || conditionMax <= 105) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 20)
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 20 || conditionMax > 80) return 0.0;
					if (conditionMax > 70 || conditionMax <= 80) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null && !mainhandItem.isItemType(::Const.Items.ItemType.RangedWeapon)) // Rolled and equipped melee weapon. Did not roll throwing.
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Spear))
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    	}
	    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Dagger))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_dagger"));
	    	}
	    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
	    	}
	    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 2);
	    	}
	    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Polearm))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	    	}
	    	else (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
	    	{
	    		::Reforged.Skills.addPerkGroupOfWeapon(this, 3);
	    	}
		}

		foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag)) // Check all bag slots for items. Melee weapon in bag or rolled a shield and added to bag.
		{
			if (item.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				if (item.isWeaponType(::Const.Items.WeaponType.Spear))
		    	{
		    		::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
		    	}
    	    	else if (item.isWeaponType(::Const.Items.WeaponType.Dagger))
    	    	{
    	    		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
    	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_dagger"));
    	    	}
    	    	else if (item.isWeaponType(::Const.Items.WeaponType.Sword))
    	    	{
    	    		::Reforged.Skills.addPerkGroupOfWeapon(this, item, 3);
    	    	}
    	    	else if (item.isWeaponType(::Const.Items.WeaponType.Cleaver))
    	    	{
    	    		::Reforged.Skills.addPerkGroupOfWeapon(this, item, 2);
    	    	}
    			else if (item.isWeaponType(::Const.Items.WeaponType.Polearm))
    	    	{
    	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
    	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
    	    	}
    	    	else (item.isWeaponType(::Const.Items.WeaponType.Flail))
    	    	{
    	    		::Reforged.Skills.addPerkGroupOfWeapon(this, item, 3);
    	    	}
			}
		}

		local offhand = this.getOffhandItem();
	    if (offhand == null || offhand.isItemType(::Const.Items.ItemType.Tool) && this.m.Items.getItemsByFunctionAtSlot(::Const.ItemSlot.Bag, @(item) item.isItemType(::Const.Items.ItemType.TwoHanded) || item.isItemType(::Const.Items.ItemType.Shield)).len() != 0) // offhand free or net AND does not have a two handed weapon or shield in the bag.
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		}
	}
});

