this.rf_brigandine_harness <- ::inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_brigandine_harness";
		this.m.Name = "Brigandine Harness";
		this.m.Description = "A brigandine shirt over mail with spaulders and splinted vambraces providing excellent protection with only moderate mobility loss.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_brigandine_harness"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 270;
		this.m.ConditionMax = 270;
		this.m.StaminaModifier = -28;
	}
});
