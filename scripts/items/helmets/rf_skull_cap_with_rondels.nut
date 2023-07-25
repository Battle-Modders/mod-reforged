this.rf_skull_cap_with_rondels <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_skull_cap_with_rondels";
		this.m.Name = "Skull Cap with Rondels";
		this.m.Description = "A skull cap with rondels to protect the sides of the head.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1200;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -6;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_skull_cap_with_rondels";
		this.m.SpriteDamaged = "rf_skull_cap_with_rondels_damaged";
		this.m.SpriteCorpse = "rf_skull_cap_with_rondels_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_skull_cap_with_rondels.png";
	}
});
