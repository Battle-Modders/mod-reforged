this.rf_reinforced_footman_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_reinforced_footman_armor";
		this.m.Name = "Reinforced Footman Armor";
		this.m.Description = "This heavy armor of mail and gambeson has been reinforced with scale plates and a plate spauldor.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4000;
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
		this.m.StaminaModifier = -32;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_reinforced_footman_armor";
		this.m.SpriteDamaged = "rf_reinforced_footman_armor_damaged";
		this.m.SpriteCorpse = "rf_reinforced_footman_armor_dead";
		this.m.IconLarge = "armor/inventory_rf_reinforced_footman_armor.png";
		this.m.Icon = "armor/icon_rf_reinforced_footman_armor.png";
	}
});
