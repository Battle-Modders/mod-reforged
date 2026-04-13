// Ancient Praetorian
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_heavy", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ResurrectionValue = 9.0; // vanilla 5
	}}.create;

	q.onInit = @() { function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonHeavy);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 100)
		// {
		// 	b.IsSpecializedInPolearms = true;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/khopesh"]
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.addArray([
					[1, "scripts/items/weapons/ancient/crypt_cleaver"],
					[1, "scripts/items/weapons/ancient/rhomphaia"]
				]);
			}

			this.m.Items.equip(::new(weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/tower_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/ancient/ancient_plated_mail_hauberk"],
				[1, "scripts/items/armor/ancient/ancient_scale_coat"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_honorguard_helmet"));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isAoE())
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
			}
			if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}}.onSpawned;

	q.onSkillsUpdated = @(__original) { function onSkillsUpdated()
	{
		__original();
		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			this.m.Skills.removeByID("perk.rf_bloodlust");
		}
	}}.onSkillsUpdated;
});
