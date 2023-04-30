this.rf_half_closed_sallet_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_half_closed_sallet_with_mail";
		this.m.Name = "Half Closed Sallet with Mail";
		this.m.Description = "A finely crafted half-closed Sallet over a mail coif. Provides excellent protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4000;
		this.m.Condition = 290;
		this.m.ConditionMax = 290;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_half_closed_sallet_with_mail";
		this.m.SpriteDamaged = "rf_half_closed_sallet_with_mail_damaged";
		this.m.SpriteCorpse = "rf_half_closed_sallet_with_mail_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_half_closed_sallet_with_mail.png";
	}
});
