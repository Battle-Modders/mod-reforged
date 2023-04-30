this.rf_half_closed_sallet_with_bevor <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_half_closed_sallet_with_bevor";
		this.m.Name = "Half Closed Sallet with Bevor";
		this.m.Description = "A finely crafted half-closed Sallet paired with an equally finely crafted bevor helmet. An expensive piece only seen on the most wealthy of knights.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5000;
		this.m.Condition = 315;
		this.m.ConditionMax = 315;
		this.m.StaminaModifier = -20;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_half_closed_sallet_with_bevor";
		this.m.SpriteDamaged = "rf_half_closed_sallet_with_bevor_damaged";
		this.m.SpriteCorpse = "rf_half_closed_sallet_with_bevor_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_half_closed_sallet_with_bevor.png";
	}
});
