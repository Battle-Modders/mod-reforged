this.rf_draugr_huskarl <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_DraugrHuskarl;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrHuskarl.XP;
		this.rf_draugr.create();
		this.m.ResurrectionValue = 11;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_huskarl";
	}

	function onInit()
	{
		this.rf_draugr.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_DraugrHuskarl);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Skills.add(::new("scripts/skills/effects/rf_unnerving_presence_effect"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vanquisher"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_light_horned_helmet",
				"rf_draugr_horned_helmet",
				"rf_draugr_heavy_horned_helmet"
			]).roll();

			this.m.Items.equip(::new("scripts/items/helmets/rf_draugr/" + helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_skull_and_plate_armor",
				"rf_draugr_metal_armor",
				"rf_draugr_crude_metal_armor"
			]).roll();

			this.m.Items.equip(::new("scripts/items/armor/rf_draugr/" + armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_sword",
				"rf_draugr_battle_axe",
				"rf_draugr_greataxe"
			]).roll();

			this.m.Items.equip(::new("scripts/items/weapons/rf_draugr/" + weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/rf_draugr/rf_draugr_round_shield"));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
				this.m.Skills.removeByID("perk.rf_tempo");
				this.m.Skills.removeByID("actives.rf_passing_step");
				this.m.Skills.removeByID("perk.rf_en_garde");
			}

			if (::Reforged.Items.isDuelistValid(mainhandItem))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
		}

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
			this.m.Skills.removeByID("actives.rf_cover_ally");
		}
	}
});
