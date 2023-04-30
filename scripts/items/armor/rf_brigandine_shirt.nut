this.rf_brigandine_shirt <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_brigandine_shirt";
		this.m.Name = "Brigandine Shirt";
		this.m.Description = "A cloth shirt with embedded, riveted and overlapping plates worn over linen and aketon. It provides great protection with minimal mobility loss.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = -19;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_brigandine_shirt";
		this.m.SpriteDamaged = "rf_brigandine_shirt_damaged";
		this.m.SpriteCorpse = "rf_brigandine_shirt_dead";
		this.m.IconLarge = "armor/inventory_rf_brigandine_shirt.png";
		this.m.Icon = "armor/icon_rf_brigandine_shirt.png";
	}
});
