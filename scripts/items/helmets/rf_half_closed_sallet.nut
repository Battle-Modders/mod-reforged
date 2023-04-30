this.rf_half_closed_sallet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_half_closed_sallet";
		this.m.Name = "Half Closed Sallet";
		this.m.Description = "A finely crafted half-closed Sallet. Provides excellent defense with some vision loss.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2400;
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -10;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_half_closed_sallet";
		this.m.SpriteDamaged = "rf_half_closed_sallet_damaged";
		this.m.SpriteCorpse = "rf_half_closed_sallet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_half_closed_sallet.png";
	}
});
