// Fallen Hero is now this entity and it is a higher tier unit than the vanilla zombie_knight.
this.rf_zombie_hero <- ::inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = ::Const.EntityType.RF_ZombieHero;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieHero.XP;
		this.m.IsResurrectingOnFatality = true;
		this.m.ResurrectionValue = 10.0;
		this.m.ResurrectionChance = 90;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_hero";
		this.setName(::Const.Strings.EntityName[this.m.Type]);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (this.m.IsHeadless)
		{
			_hitInfo.BodyPart = ::Const.BodyPart.Body;
			_hitInfo.BodyDamageMult = 1.0;
		}

		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ZombieHero);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
	}

	// Vanilla achievement for killing Fallen Hero (vanilla zombie_knight)
	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!::Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("RestlessDead", 1, 1);
		}

		this.zombie.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onResurrected( _info )
	{
		this.zombie.onResurrected(_info);

		if (!_info.IsHeadAttached)
		{
			this.m.IsHeadless = true;
			this.m.Name = "Headless " + ::Const.Strings.EntityName[this.m.Type];
			this.m.Items.unequip(this.m.Items.getItemAtSlot(::Const.ItemSlot.Head));
			this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [];
			this.m.Sound[::Const.Sound.ActorEvent.Death] = [];
			this.m.Sound[::Const.Sound.ActorEvent.Resurrect] = [];
			this.m.Sound[::Const.Sound.ActorEvent.Idle] = [];
			this.getSprite("head").setBrush("zombify_no_head");
			this.getSprite("head").Saturation = 1.0;
			this.getSprite("head").Color = ::createColor("#ffffff");
			this.getSprite("injury").Visible = false;
			this.getSprite("hair").resetBrush();
			this.getSprite("beard").resetBrush();
			this.getSprite("beard_top").resetBrush();
			this.getSprite("status_rage").resetBrush();
			this.getSprite("tattoo_head").resetBrush();
			this.getSprite("helmet").Visible = false;
			this.getSprite("helmet_damage").Visible = false;
			this.getSprite("body_blood").Visible = false;
			this.getSprite("dirt").Visible = false;
		}
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/arming_sword"],
				[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/noble_sword"],
				[1, "scripts/items/weapons/military_cleaver"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"]
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.addArray([
					[1, "scripts/items/weapons/bardiche"],
					[1, "scripts/items/weapons/longsword"],
					[1, "scripts/items/weapons/greataxe"],
					[1, "scripts/items/weapons/rf_kriegsmesser"],
					[1, "scripts/items/weapons/rf_poleaxe"],
					[1, "scripts/items/weapons/two_handed_flail"],
					[1, "scripts/items/weapons/two_handed_flanged_mace"],
					[1, "scripts/items/weapons/two_handed_hammer"],
					[1, "scripts/items/weapons/greatsword"]
				]);
			}

			this.m.Items.equip(::new(weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/worn_heater_shield"],
				[1, "scripts/items/shields/worn_kite_shield"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/decayed_coat_of_scales"],
				[1, "scripts/items/armor/decayed_coat_of_plates"]
			]).roll());

			if (::Math.rand(1, 100) <= 33)
			{
				armor.setArmor(::Math.round(armor.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(armor);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/decayed_full_helm"],
				[1, "scripts/items/helmets/decayed_great_helm"]
			]).roll());

			if (::Math.rand(1, 100) <= 33)
			{
				helmet.setArmor(::Math.round(helmet.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(helmet);
		}
	}

	function onSpawned()
	{
		this.zombie.onSpawned();

		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addAllPerkGroupsOfEquippedWeapon(this);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword, true, true)) // pure sword
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
			}

			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}

			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				if (::Reforged.Items.isDuelistValid(mainhandItem))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
				}
				else
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
				}
			}
		}

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}
	}

	function onSkillsUpdated()
	{
		this.zombie.onSkillsUpdated();

		local mainhandItem = this.getMainhandItem();
		if (mainhandItem == null)
			return;

		if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			this.m.Skills.removeByID("actives.rf_bearded_blade");
			this.m.Skills.removeByID("actives.rf_hook_shield");
		}
		else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			this.m.Skills.removeByID("perk.rf_bloodlust");
		}

		if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			this.m.Skills.removeByID("perk.rf_tempo");
			this.m.Skills.removeByID("actives.rf_passing_step");
		}
	}

	function makeMiniboss()
	{
		if (!this.zombie.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		if (::Math.rand(1, 100) <= 50 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_axe"],
				[1, "scripts/items/weapons/named/named_cleaver"],
				[1, "scripts/items/weapons/named/named_flail"],
				[1, "scripts/items/weapons/named/named_rf_longsword"],
				[1, "scripts/items/weapons/named/named_greataxe"],
				[1, "scripts/items/weapons/named/named_greatsword"],
				[1, "scripts/items/weapons/named/named_rf_kriegsmesser"],
				[1, "scripts/items/weapons/named/named_mace"],
				[1, "scripts/items/weapons/named/named_sword"],
				[1, "scripts/items/weapons/named/named_two_handed_flail"],
				[1, "scripts/items/weapons/named/named_two_handed_hammer"],
				[1, "scripts/items/weapons/named/named_two_handed_mace"],
				[1, "scripts/items/weapons/named/named_warhammer"]
			]).roll()));
		}
		else if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(::Const.Items.NamedUndeadShields)));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));

		return true;
	}
});
