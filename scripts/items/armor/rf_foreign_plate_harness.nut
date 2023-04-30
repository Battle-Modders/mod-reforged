this.rf_foreign_plate_harness <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_foreign_plate_harness";
		this.m.Name = "Foreign Plate Harness";
		this.m.Description = "An exceptional plate harness from a foreign land, offering better mobility than local designs. Some of the most expensive armor crowns can buy.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 12000;
		this.m.Condition = 360;
		this.m.ConditionMax = 360;
		this.m.StaminaModifier = -40;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_foreign_plate_harness";
		this.m.SpriteDamaged = "rf_foreign_plate_harness_damaged";
		this.m.SpriteCorpse = "rf_foreign_plate_harness_dead";
		this.m.IconLarge = "armor/inventory_rf_foreign_plate_harness.png";
		this.m.Icon = "armor/icon_rf_foreign_plate_harness.png";
	}
});
