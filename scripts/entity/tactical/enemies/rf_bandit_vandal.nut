this.rf_bandit_vandal <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditVandal;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditVandal.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditVandal);
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

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local throwing = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/throwing_spear"]
	    	]).rollChance(33);

			if (throwing != null) this.m.Items.equip(::new(throwing));
		}

		local weapon = ::MSU.Class.WeightedContainer([
    		[1, "scripts/items/weapons/boar_spear"],
			[1, "scripts/items/weapons/falchion"],
			[1, "scripts/items/weapons/flail"],
			[1, "scripts/items/weapons/hand_axe"],
			[1, "scripts/items/weapons/military_pick"],
			[1, "scripts/items/weapons/morning_star"],
			[1, "scripts/items/weapons/scramasax"],

			[1, "scripts/items/weapons/warbrand"]
    	]).roll();
		weapon = ::new(weapon);

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/wooden_shield"]
			]).rollChance(60);

			if (shield != null) this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 80 || conditionMax > 115) return 0.0;
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
					if (conditionMax < 40 || conditionMax > 115) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null && mainhandItem.isItemType(::Const.Items.ItemType.MeleeWeapon)) //Rolled and equipped one handed melee weapon
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Spear))
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
	    	}
	    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_from_all_sides"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_whirling_death"));
	    	}
	    	else
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    	}
		}
		else //Rolled two handed weapon and added to bag.
		{
			foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag))
			{
				if (item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Sword))
		    	{
		    		::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
		    	}
			}
		}
	}
});

