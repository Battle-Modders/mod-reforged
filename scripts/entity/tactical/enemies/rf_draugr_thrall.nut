this.rf_draugr_thrall <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_DraugrThrall;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrThrall.XP;
		this.rf_draugr.create();
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) <= 33)
		{
			local helmet = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_headband",
				"rf_draugr_headwrap"
			]).roll();

			this.m.Items.equip(::new("scripts/items/helmets/rf_draugr/" + helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && ::Math.rand(1, 100) <= 70)
		{
			local armor = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_skull_wraps",
				"rf_draugr_leather_wraps"
			]).roll();

			this.m.Items.equip(::new("scripts/items/armor/rf_draugr/" + armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_axe",
				"rf_draugr_cleaver"
			]).roll();

			this.m.Items.equip(::new("scripts/items/weapons/rf_draugr/" + weapon));
		}
	}

	function onSpawned()
	{
	}
});
