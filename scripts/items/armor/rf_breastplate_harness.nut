this.rf_breastplate_harness <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_breastplate_harness";
		this.m.Name = "Breastplate Harness";
		this.m.Description = "An exquisite breastplate with fauld, spaulders, rerebraces, vambraces and ailette. Offers phenomenal protection for the wealthiest of warriors.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8500;
		this.m.Condition = 340;
		this.m.ConditionMax = 340;
		this.m.StaminaModifier = -40;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_breastplate_harness";
		this.m.SpriteDamaged = "rf_breastplate_harness_damaged";
		this.m.SpriteCorpse = "rf_breastplate_harness_dead";
		this.m.IconLarge = "armor/inventory_rf_breastplate_harness.png";
		this.m.Icon = "armor/icon_rf_breastplate_harness.png";
	}
});
