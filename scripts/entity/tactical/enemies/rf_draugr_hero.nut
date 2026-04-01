this.rf_draugr_hero <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_DraugrHero;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrHero.XP;
		this.rf_draugr.create();
		this.m.ResurrectionValue = 13.5;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_draugr_hero";
	}

	function onInit()
	{
		this.rf_draugr.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_DraugrHero);
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
				"rf_draugr_antler_helmet",
				"rf_draugr_decorated_nasal_helmet"
			]).roll();

			this.m.Items.equip(::new("scripts/items/helmets/rf_draugr/" + helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_horns_and_plate_armor",
				"rf_draugr_runic_metal_armor",
				"rf_draugr_decorated_metal_armor"
			]).roll();

			this.m.Items.equip(::new("scripts/items/armor/rf_draugr/" + armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_greataxe"
			]).roll();

			this.m.Items.equip(::new("scripts/items/weapons/rf_draugr/" + weapon));
		}
	}

	function makeMiniboss()
	{
		if (!this.rf_draugr.makeMiniboss())
			return false;

		local weapons = ::MSU.Class.WeightedContainer().addMany(1, [
			"scripts/items/weapons/named/named_rf_draugr_bardiche",
			"scripts/items/weapons/named/named_rf_draugr_greatsword"
		]);

		this.m.Items.equip(::new(weapons.roll()));
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
					this.m.Skills.removeByID("perk.rf_en_garde");
				}
				this.m.Skills.removeByID("perk.rf_tempo");
				this.m.Skills.removeByID("actives.rf_passing_step");
			}

			if (::Reforged.Items.isDuelistValid(mainhandItem))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.removeByID("actives.rf_cover_ally");
		}
	}
});
