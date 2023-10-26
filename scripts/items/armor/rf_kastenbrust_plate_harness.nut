this.rf_kastenbrust_plate_harness <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_kastenbrust_plate_harness";
		this.m.Name = "Kastenbrust Plate Harness";
		this.m.Description = "A full set of plate armor with a box shaped cuirass over a mail hauberk. Some of the most expensive armor crowns can buy.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_kastenbrust_plate_harness"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 9000;
		this.m.Condition = 360;
		this.m.ConditionMax = 360;
		this.m.StaminaModifier = -42;
	}
});
