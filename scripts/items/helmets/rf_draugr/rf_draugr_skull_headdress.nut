this.rf_draugr_skull_headdress <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_draugr_skull_headdress";
		this.m.Name = "Barrowkin Skull Headdress";
		this.m.Description = "A ram's skull built into a headdress, likely used by some spiritual leader.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = ::Math.rand(1, 2);
		this.m.VariantString = "rf_draugr_helmet_09";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 250;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -5;
		this.m.Vision = -1;
	}
});
