this.rf_draugr_skull_and_bones_armor <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_draugr_skull_and_bones_armor";
		this.m.Name = "Barrowkin Skull and Bones Armor";
		this.m.Description = "";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_armor_07";
		this.updateVariant();
		this.m.ImpactSound = clone ::Const.Sound.ArmorBoneImpact;
		this.m.ImpactSound.extend(::Const.Sound.ArmorLeatherImpact);
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 170;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -7;
	}
});
