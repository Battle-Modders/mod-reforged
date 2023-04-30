this.rf_sallet_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_sallet_helmet";
		this.m.Name = "Sallet Helmet";
		this.m.Description = "A simple, well-made sallet helmet offering great protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1500;
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.StaminaModifier = -7;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_sallet_helmet";
		this.m.SpriteDamaged = "rf_sallet_helmet_damaged";
		this.m.SpriteCorpse = "rf_sallet_helmet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_sallet_helmet.png";
	}
});
