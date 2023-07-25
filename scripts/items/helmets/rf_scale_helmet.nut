this.rf_scale_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_scale_helmet";
		this.m.Name = "Scale Helmet";
		this.m.Description = "A helmet made of overlapping iron scales. Provides mediocre protection when compared to the weight.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = ::Const.Sound.ArmorChainmailImpact;
		this.m.Value = 300;
		this.m.Condition = 95;
		this.m.ConditionMax = 95;
		this.m.StaminaModifier = -5;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_scale_helmet";
		this.m.SpriteDamaged = "rf_scale_helmet_damaged";
		this.m.SpriteCorpse = "rf_scale_helmet_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_scale_helmet.png";
	}
});
