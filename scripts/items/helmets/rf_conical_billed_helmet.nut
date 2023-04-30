this.rf_conical_billed_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_conical_billed_helmet";
		this.m.Name = "Conical Billed Helmet";
		this.m.Description = "A helmet of foreign styling, the billed visor covers more of the face with less overall metal.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2500;
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -12;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_conical_billed_helmet";
		this.m.SpriteDamaged = "rf_conical_billed_helmet_damaged";
		this.m.SpriteCorpse = "rf_conical_billed_helmet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_conical_billed_helmet.png";
	}
});
