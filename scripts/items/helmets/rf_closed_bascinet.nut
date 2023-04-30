this.rf_closed_bascinet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_closed_bascinet";
		this.m.Name = "Closed Bascinet";
		this.m.Description = "A well-made closed bascinet offering excellent protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4500;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -19;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_closed_bascinet";
		this.m.SpriteDamaged = "rf_closed_bascinet_damaged";
		this.m.SpriteCorpse = "rf_closed_bascinet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_closed_bascinet.png";
	}
});
