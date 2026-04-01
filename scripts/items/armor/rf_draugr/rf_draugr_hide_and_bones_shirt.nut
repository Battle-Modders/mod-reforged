this.rf_draugr_hide_and_bones_shirt <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_hide_and_bones_shirt";
		this.m.Name = "Barrowkin Hide and Bones Shirt";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_04";
		this.updateVariant();
		this.m.ImpactSound = clone ::Const.Sound.ArmorBoneImpact;
		this.m.ImpactSound.extend(::Const.Sound.ArmorLeatherImpact);
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 80;
		this.m.Condition = 45;
		this.m.ConditionMax = 45;
		this.m.StaminaModifier = -3;
	}
});
