this.rf_heavy_plate_harness <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_heavy_plate_harness";
		this.m.Name = "Heavy Plate Harness";
		this.m.Description = "This heavy plate harness offers near-unbeatable protection with some loss of mobility. Some of the most expensive armor crowns can buy.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10500;
		this.m.Condition = 380;
		this.m.ConditionMax = 380;
		this.m.StaminaModifier = -44;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_heavy_plate_harness";
		this.m.SpriteDamaged = "rf_heavy_plate_harness_damaged";
		this.m.SpriteCorpse = "rf_heavy_plate_harness_dead";
		this.m.IconLarge = "armor/inventory_rf_heavy_plate_harness.png";
		this.m.Icon = "armor/icon_rf_heavy_plate_harness.png";
	}
});
