this.rf_bandit_highwayman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditHighwayman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditHighwayman.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditHighwayman);
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
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/flail"],
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/military_pick"],
				[1, "scripts/items/weapons/morning_star"],

				[1, "scripts/items/weapons/longaxe"],
				[1, "scripts/items/weapons/polehammer"]
			]).roll();

			weapon = ::new(weapon);
			this.m.Items.equip(weapon);

			if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
			{
				local shield = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/shields/kite_shield"],
					[1, "scripts/items/shields/heater_shield"]
				]).roll();

				this.m.Items.equip(::new(shield));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 140 || conditionMax > 190) return 0.0;
					if (conditionMax > 170 || conditionMax <= 190) return _weight * 0.5;
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
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 115 || conditionMax > 150) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_splitter"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
				}
				else (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
				}
			}
			else //two handed weapon
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_intimidate"));
				}
				else //2h hammer
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_dent_armor"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_hammer"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_deep_impact"));
				}
			}
		}

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_line_breaker"));
		}
	}
});

