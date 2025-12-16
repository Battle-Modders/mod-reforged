this.rf_draugr_fur_mantle <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_fur_mantle";
		this.m.Name = "Barrowkin Fur Mantle";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_02";
		this.updateVariant();
		this.m.ImpactSound = clone ::Const.Sound.ArmorLeatherImpact;
		this.m.ImpactSound.extend(::Const.Sound.ArmorChainmailImpact);
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 30;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
	}
});
