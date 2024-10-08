this.rf_brigandine_shirt <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_brigandine_shirt";
		this.m.Name = "Brigandine Shirt";
		this.m.Description = "A cloth shirt with embedded, riveted and overlapping plates worn over linen and aketon. It provides good protection with minimal mobility loss.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = ::Math.rand(1, 5);
		this.m.VariantString = "rf_brigandine_shirt"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3000;
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -21;
	}
});
