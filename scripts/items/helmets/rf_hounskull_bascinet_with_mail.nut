this.rf_hounskull_bascinet_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_hounskull_bascinet_with_mail";
		this.m.Name = "Hounskull Bascinet with Mail";
		this.m.Description = "This bascinet with hounskull visor provides phenomenal defense and coverage. Some of the best protection crowns can buy.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_hounskull_bascinet_with_mail"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 340;
		this.m.ConditionMax = 340;
		this.m.StaminaModifier = -22;
		this.m.Vision = -3;
	}
});
