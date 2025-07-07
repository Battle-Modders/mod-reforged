// We have a higher tier unit RF_ZombieHero in Reforged which is the new Fallen Hero
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_knight", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ResurrectionValue = 6.0; // vanilla 5.0
		this.m.ResurrectionChance = 60; // vanilla 90
	}}.create;

	q.onInit = @() { function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieKnight);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		// b.IsAffectedByNight = false;	// Redundant. Set via rf_zombie_racial
		// b.IsAffectedByInjuries = false;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToBleeding = true;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToPoison = true;	// Redundant. Set via rf_zombie_racial
		// b.FatigueDealtPerHitMult = 2.0;	// Set via rf_zombie_racial

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 90)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
	}}.onInit;

	q.onDeath = @() { function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		// removing RestlessDead achievement (kill a Fallen Hero) and moving it to Reforged's new Fallen Hero
	}}.onDeath;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (::Math.rand(1, 100) > 85)
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/longaxe"],
					[1, "scripts/items/weapons/rf_poleflail"],
					[1, "scripts/items/weapons/polehammer"]
				]).roll()));
			}
			else
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/arming_sword"],
					[1, "scripts/items/weapons/flail"],
					[1, "scripts/items/weapons/hand_axe"],
					[1, "scripts/items/weapons/military_pick"],
					[1, "scripts/items/weapons/morning_star"],

					[1, "scripts/items/weapons/rf_battle_axe"],
					[1, "scripts/items/weapons/rf_greatsword"],
					[1, "scripts/items/weapons/rf_two_handed_falchion"],
					[1, "scripts/items/weapons/two_handed_mace"],
					[1, "scripts/items/weapons/warbrand"]
				]).roll()));
			}
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
				[1, "scripts/items/armor/decayed_reinforced_mail_hauberk"],
				[1, "scripts/items/armor/decayed_coat_of_scales"]
			]).roll());

			if (::Math.rand(1, 100) <= 50)
			{
				armor.setArmor(::Math.round(armor.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(armor);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/decayed_closed_flat_top_with_sack"],
				[1, "scripts/items/helmets/decayed_closed_flat_top_with_mail"]
			]).roll());

			if (::Math.rand(1, 100) <= 50)
			{
				helmet.setArmor(::Math.round(helmet.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(helmet);
		}
	}}.assignRandomEquipment;

	q.onSpawned = @(__original) { function onSpawned()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}}.onSpawned;

	q.onSkillsUpdated = @(__original) { function onSkillsUpdated()
	{
		__original();
		local weapon = this.getMainhandItem();
		if (weapon == null)
			return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			this.m.Skills.removeByID("actives.rf_bearded_blade");
			this.m.Skills.removeByID("actives.rf_hook_shield");
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			this.m.Skills.removeByID("perk.rf_bloodlust");
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			this.m.Skills.removeByID("perk.rf_tempo");
			this.m.Skills.removeByID("actives.rf_passing_step");
		}
	}}.onSkillsUpdated;
});
