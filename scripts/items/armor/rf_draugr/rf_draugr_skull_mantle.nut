this.rf_draugr_skull_mantle <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_skull_mantle";
		this.m.Name = "Barrowkin Skull Mantle";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_13";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3600;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -24;
	}
});
