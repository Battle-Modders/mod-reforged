::mods_hookExactClass("entity/tactical/enemies/bandit_raider", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRaider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/military_pick"],
				[1, "scripts/items/weapons/morning_star"],
				[1, "scripts/items/weapons/flail"],

				[1, "scripts/items/weapons/longaxe"],
				[1, "scripts/items/weapons/polehammer"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/shields/wooden_shield"],
				[1.0, "scripts/items/shields/kite_shield"],
				[0.33, "scripts/items/shields/heater_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 115 || conditionMax > 150) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}


		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Apply = function ( _script, _weight )
				{
					if (_script == "scripts/items/helmets/kettle_hat") return _weight * 0.5;
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 80 || conditionMax > 140) return 0.0;
					if (conditionMax > 125 || conditionMax <= 140) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	o.onSetupEntity <- function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_vigorous_assault"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_shield_splitter"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_axe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
				}
				else
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
				}
			}
			else //Two Handed Weapon
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
				}
				else //polehammer
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_dent_armor"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_hammer"));
				}
			}
		}
	}
});
