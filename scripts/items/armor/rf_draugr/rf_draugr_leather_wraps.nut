this.rf_draugr_leather_wraps <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_leather_wraps";
		this.m.Name = "Barrowkin Leather Wraps";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_05";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 40;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -2;
	}
});
