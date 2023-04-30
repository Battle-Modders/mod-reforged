this.rf_brigandine_harness <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_brigandine_harness";
		this.m.Name = "Brigandine Harness";
		this.m.Description = "A brigandine shirt over mail with spaulders and splinted vambaces providing excellent protection with only moderate mobility loss.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5400;
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
		this.m.StaminaModifier = -28;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_brigandine_harness";
		this.m.SpriteDamaged = "rf_brigandine_harness_damaged";
		this.m.SpriteCorpse = "rf_brigandine_harness_dead";
		this.m.IconLarge = "armor/inventory_rf_brigandine_harness.png";
		this.m.Icon = "armor/icon_rf_brigandine_harness.png";
	}
});
