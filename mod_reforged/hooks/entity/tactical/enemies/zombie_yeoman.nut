::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_yeoman", function(q) {
	q.onInit = @() { function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieYeoman);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		// b.IsAffectedByNight = false;	// Redundant. Set via rf_zombie_racial
		// b.IsAffectedByInjuries = false;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToBleeding = true;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToPoison = true;	// Redundant. Set via rf_zombie_racial

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 20)
		// {
		// 	b.FatigueDealtPerHitMult = 2.0;	// Set via rf_zombie_racial
		// }

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 90)
		// {
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();

		// Reforged
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (::Math.rand(1, 100) > 85 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/hooked_blade"],
					[1, "scripts/items/weapons/rf_reinforced_wooden_poleflail"],
					[1, "scripts/items/weapons/two_handed_wooden_hammer"]
				]).roll()));
			}
			else
			{
				local weapons = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/bludgeon"],
					[1, "scripts/items/weapons/hatchet"],
					[1, "scripts/items/weapons/hand_axe"],
					[1, "scripts/items/weapons/scramasax"],
					[1, "scripts/items/weapons/militia_spear"],
					[1, "scripts/items/weapons/shortsword"]
				]);

				this.m.Items.equip(::new(weapons.roll()));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/padded_leather"],
				[1, "scripts/items/armor/worn_mail_shirt"],
				[1, "scripts/items/armor/patched_mail_shirt"],
				[1, "scripts/items/armor/ragged_surcoat"],
				[1, "scripts/items/armor/basic_mail_shirt"]
			]).roll());

			if (::Math.rand(1, 100) <= 66)
			{
				armor.setArmor(::Math.round(armor.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(armor);
		}

		if (this.Math.rand(1, 100) <= 75 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/aketon_cap"],
				[1, "scripts/items/helmets/full_aketon_cap"],
				[1, "scripts/items/helmets/kettle_hat"],
				[1, "scripts/items/helmets/padded_kettle_hat"],
				[1, "scripts/items/helmets/dented_nasal_helmet"],
				[1, "scripts/items/helmets/mail_coif"],
				[1, "scripts/items/helmets/full_leather_cap"]
			]).roll());

			if (::Math.rand(1, 100) <= 66)
			{
				helmet.setArmor(::Math.round(helmet.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(helmet);
		}
	}}.assignRandomEquipment;
});
