this.rf_snubnose_bascinet_with_mail <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_snubnose_bascinet_with_mail";
		this.m.Name = "Snubnose Bascinet with Mail";
		this.m.Description = "This bascinet with snubnose visor provides phenomenal defense and coverage. Some of the best protection crowns can buy.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_snubnose_bascinet_with_mail"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5500;
		this.m.Condition = 330;
		this.m.ConditionMax = 330;
		this.m.StaminaModifier = -21;
		this.m.Vision = -3;
	}
});
