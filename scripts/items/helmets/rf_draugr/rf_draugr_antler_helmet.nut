this.rf_draugr_antler_helmet <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_draugr_antler_helmet";
		this.m.Name = "Barrowkin Antler Helmet";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = ::Math.rand(1, 2);
		this.m.VariantString = "rf_draugr_helmet_01";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = -16;
		this.m.Vision = -2;
	}
});
