this.rf_breastplate <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_breastplate";
		this.m.Name = "Breastplate";
		this.m.Description = "A quality breastplate and fauld over a simple gambeson offering strong protection.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3400;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -24;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_breastplate";
		this.m.SpriteDamaged = "rf_breastplate_damaged";
		this.m.SpriteCorpse = "rf_breastplate_dead";
		this.m.IconLarge = "armor/inventory_rf_breastplate.png";
		this.m.Icon = "armor/icon_rf_breastplate.png";
	}
});
