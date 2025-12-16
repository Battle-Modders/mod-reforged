this.rf_draugr_huskarl <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_DraugrHuskarl;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrHuskarl.XP;
		this.rf_draugr.create();
	}

	function onInit()
	{
		this.rf_draugr.onInit();
		this.m.Skills.add(::new("scripts/skills/effects/rf_unnerving_presence_effect"));
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

	function makeMiniboss()
	{
		if (!this.rf_draugr.makeMiniboss())
			return false;

		return true;
	}

	function onSpawned()
	{
	}
});
