::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_raider", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRaider);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));	// Now granted to all humans by default
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local throwing = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/throwing_spear"]
			]).rollChance(33);

			if (throwing != null) this.m.Items.equip(::new(throwing));
		}

		local weapon = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/arming_sword"],
			[1, "scripts/items/weapons/boar_spear"],
			[1, "scripts/items/weapons/falchion"],
			[1, "scripts/items/weapons/flail"],
			[1, "scripts/items/weapons/hand_axe"],
			[1, "scripts/items/weapons/military_pick"],
			[1, "scripts/items/weapons/morning_star"],
			[1, "scripts/items/weapons/scramasax"],

			[1, "scripts/items/weapons/longaxe"],
			[1, "scripts/items/weapons/polehammer"]
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
				[1.0, "scripts/items/shields/wooden_shield"],
				[1.0, "scripts/items/shields/kite_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 105 || conditionMax > 140) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 105 || conditionMax > 140) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	q.onSetupEntity <- function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null && mainhandItem.isItemType(::Const.Items.ItemType.MeleeWeapon)) // melee weapon equipped
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
		else // melee waepon in bag
		{
			foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag))
			{
				if (item.isItemType(::Const.Items.ItemType.Weapon))
				{
					::Reforged.Skills.addPerkGroupOfWeapon(this, item, 4);
					break;
				}
			}
		}

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}
	}
});
