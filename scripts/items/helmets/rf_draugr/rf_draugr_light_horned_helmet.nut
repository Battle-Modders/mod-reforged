this.rf_draugr_light_horned_helmet <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_draugr_light_horned_helmet";
		this.m.Name = "Barrowkin Light Horned Helmet";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 1;
		this.m.VariantString = "rf_draugr_helmet_14";
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = ::Const.Sound.ArmorChainmailImpact;
		this.m.Value = 400;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.StaminaModifier = -8;
		this.m.Vision = -2;
	}
});
