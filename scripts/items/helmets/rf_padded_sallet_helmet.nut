this.rf_padded_sallet_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_padded_sallet_helmet";
		this.m.Name = "Padded Sallet Helmet";
		this.m.Description = "A well-made sallet helmet over aketon padding. Offers great protection without much weight.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = -9;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_padded_sallet_helmet";
		this.m.SpriteDamaged = "rf_padded_sallet_helmet_damaged";
		this.m.SpriteCorpse = "rf_padded_sallet_helmet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_padded_sallet_helmet.png";
	}
});
