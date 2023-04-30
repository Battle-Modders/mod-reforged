this.rf_padded_conical_billed_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_padded_conical_billed_helmet";
		this.m.Name = "Padded Conical Billed Helmet";
		this.m.Description = "A helmet of foreign styling over aketon padding, the billed visor covers more of the face with less overall metal.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2900;
		this.m.Condition = 245;
		this.m.ConditionMax = 245;
		this.m.StaminaModifier = -14;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_padded_conical_billed_helmet";
		this.m.SpriteDamaged = "rf_padded_conical_billed_helmet_damaged";
		this.m.SpriteCorpse = "rf_padded_conical_billed_helmet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_padded_conical_billed_helmet.png";
	}
});
