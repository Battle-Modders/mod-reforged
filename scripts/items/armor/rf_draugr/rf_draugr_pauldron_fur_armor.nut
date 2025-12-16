this.rf_draugr_pauldron_fur_armor <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_pauldron_fur_armor";
		this.m.Name = "Barrowkin Pauldron with Fur";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_17";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 500;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = -12;
	}
});
