this.rf_breastplate_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_breastplate_armor";
		this.m.Name = "Breastplate Armor";
		this.m.Description = "A quality breastplate and fauld over mail and aketon offers excellent protection and coverage, if you have the crowns to afford it.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 7000;
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
		this.m.StaminaModifier = -32;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_breastplate_armor";
		this.m.SpriteDamaged = "rf_breastplate_armor_damaged";
		this.m.SpriteCorpse = "rf_breastplate_armor_dead";
		this.m.IconLarge = "armor/inventory_rf_breastplate_armor.png";
		this.m.Icon = "armor/icon_rf_breastplate_armor.png";
	}
});