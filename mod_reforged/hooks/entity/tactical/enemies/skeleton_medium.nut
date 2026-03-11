// Ancient Legionary
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_medium", function(q) {
	q.onInit = @() { function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonMedium);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[0.5, "scripts/items/weapons/ancient/broken_ancient_sword"],
				[0.5, "scripts/items/weapons/ancient/ancient_sword"],
				[1, "scripts/items/weapons/ancient/ancient_spear"],
				[1, "scripts/items/weapons/ancient/falx"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new("scripts/items/shields/ancient/coffin_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/armor/ancient/ancient_mail"],
				[1.0, "scripts/items/armor/ancient/ancient_double_layer_mail"]
			]).roll();

			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				::Reforged.Skills.addPerkGroup(this, "pg.rf_dagger", 4);
			}
			else
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			}
		}
	}}.onSpawned;

	q.onSkillsUpdated = @(__original) { function onSkillsUpdated()
	{
		__original();
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem == null)
			return;

		if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			this.m.Skills.removeByID("actives.rf_passing_step");
		}
	}}.onSkillsUpdated;
});
