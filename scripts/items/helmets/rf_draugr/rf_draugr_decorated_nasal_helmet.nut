this.rf_draugr_decorated_nasal_helmet <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_draugr_decorated_nasal_helmet";
		this.m.Name = "Barrowkin Decorated Nasal Helmet";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_helmet_16";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 750;
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.StaminaModifier = -11;
		this.m.Vision = -1;
	}
});
