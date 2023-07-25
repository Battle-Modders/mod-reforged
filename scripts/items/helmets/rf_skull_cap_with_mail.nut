this.rf_skull_cap_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_skull_cap_with_mail";
		this.m.Name = "Skull Cap with Mail";
		this.m.Description = "A skull cap over mail that providing strong overall protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2000;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -12;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_skull_cap_with_mail";
		this.m.SpriteDamaged = "rf_skull_cap_with_mail_damaged";
		this.m.SpriteCorpse = "rf_skull_cap_with_mail_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_skull_cap_with_mail.png";
	}
});
