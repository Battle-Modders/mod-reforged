// Ancient Auxiliary
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_light", function(q) {
	q.onInit = @() { function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonLight);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/ancient/broken_ancient_sword"],
				[1, "scripts/items/weapons/ancient/falx"],
				[1, "scripts/items/weapons/ancient/ancient_spear"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/auxiliary_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new("scripts/items/armor/ancient/ancient_ripped_cloth"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_household_helmet"));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null && mainhandItem.isItemType(::Const.Items.ItemType.MeleeWeapon)) // melee weapon equipped
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
		}
	}}.onSpawned;
});
