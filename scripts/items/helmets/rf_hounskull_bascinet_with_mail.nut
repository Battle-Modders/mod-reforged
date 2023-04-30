this.rf_hounskull_bascinet_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_hounskull_bascinet_with_mail";
		this.m.Name = "Hounskull Bascinet with Mail";
		this.m.Description = "This bascinet with hounskull visor provides phenomanal defense and coverage. Some of the best protection crowns can buy.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 340;
		this.m.ConditionMax = 340;
		this.m.StaminaModifier = -22;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_hounskull_bascinet_with_mail";
		this.m.SpriteDamaged = "rf_hounskull_bascinet_with_mail_damaged";
		this.m.SpriteCorpse = "rf_hounskull_bascinet_with_mail_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_hounskull_bascinet_with_mail.png";
	}
});
