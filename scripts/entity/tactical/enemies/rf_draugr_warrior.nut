this.rf_draugr_warrior <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_DraugrWarrior;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrWarrior.XP;
		this.rf_draugr.create();
		this.m.ResurrectionValue = 7.5;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_warrior";
	}

	function onInit()
	{
		this.rf_draugr.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_DraugrWarrior);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vanquisher"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) <= 70)
		{
			local helmet = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_ritual_headpiece",
				"rf_draugr_claw_headband",
				"rf_draugr_dentated_headband",
				"rf_draugr_wolf_headpiece",
				"rf_draugr_antler_headband"
			]).roll();

			this.m.Items.equip(::new("scripts/items/helmets/rf_draugr/" + helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_skull_mantle",
				"rf_draugr_skull_and_bones_armor",
				"rf_draugr_hide_and_bones_shirt",
				"rf_draugr_fur_mantle",
				"rf_draugr_leather_and_bones_harness"
			]).roll();

			this.m.Items.equip(::new("scripts/items/armor/rf_draugr/" + armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_axe",
				"rf_draugr_cleaver",
				"rf_draugr_voulge",
				"rf_draugr_battle_axe"
			]).roll();

			this.m.Items.equip(::new("scripts/items/weapons/rf_draugr/" + weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && ::Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(::new("scripts/items/shields/rf_draugr/rf_draugr_round_shield"));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
				this.m.Skills.removeByID("perk.rf_bloodlust");
			}
		}

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
			this.m.Skills.removeByID("actives.rf_cover_ally");
		}
		else if (mainhandItem != null)
		{
			if (::Reforged.Items.isDuelistValid(mainhandItem))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}
});
