this.rf_sallet_helmet_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_sallet_helmet_with_mail";
		this.m.Name = "Sallet Helmet with Mail";
		this.m.Description = "A well-made sallet helmet over a mail coif. Provides great overall protection for any soldier.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2500;
		this.m.Condition = 240;
		this.m.ConditionMax = 240;
		this.m.StaminaModifier = -14;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_sallet_helmet_with_mail";
		this.m.SpriteDamaged = "rf_sallet_helmet_with_mail_damaged";
		this.m.SpriteCorpse = "rf_sallet_helmet_with_mail_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_sallet_helmet_with_mail.png";
	}
});

