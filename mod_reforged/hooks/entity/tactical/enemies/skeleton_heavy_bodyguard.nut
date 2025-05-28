// Ancient Honor Guard
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_heavy_bodyguard", function(q) {
	q.onInit = @() { function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonHeavy);
		b.Initiative -= 50;
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInPolearms = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/khopesh"],
				[1, "scripts/items/weapons/ancient/crypt_cleaver"],
				[1, "scripts/items/weapons/ancient/rhomphaia"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/tower_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/armor/ancient/ancient_plate_harness"],
				[1.0, "scripts/items/armor/ancient/ancient_plated_scale_hauberk"]
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
});
