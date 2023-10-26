this.rf_great_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_great_helm";
		this.m.Name = "Great Helm";
		this.m.Description = "A heavy, fully enclosed helm that extremely hinders vision but makes up for it with phenomenal protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_great_helm"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4500;
		this.m.Condition = 360;
		this.m.ConditionMax = 360;
		this.m.StaminaModifier = -26;
		this.m.Vision = -4;
	}
});
