this.rf_sallet_helmet_with_bevor <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_sallet_helmet_with_bevor";
		this.m.Name = "Sallet Helmet with Bevor";
		this.m.Description = "A well-made sallet helmet paired with a finely crafted bevor. An expensive piece offering excellent protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_sallet_helmet_with_bevor"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3500;
		this.m.Condition = 275;
		this.m.ConditionMax = 275;
		this.m.StaminaModifier = -17;
		this.m.Vision = -2;
	}
});
