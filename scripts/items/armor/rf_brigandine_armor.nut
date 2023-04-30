this.rf_brigandine_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_brigandine_armor";
		this.m.Name = "Brigandine Armor";
		this.m.Description = "A cloth shirt with embedded, riveted and overlapping plates worn over a long mail shirt. It provides great protection with only moderate mobility loss.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4400;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = -26;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_brigandine_armor";
		this.m.SpriteDamaged = "rf_brigandine_armor_damaged";
		this.m.SpriteCorpse = "rf_brigandine_armor_dead";
		this.m.IconLarge = "armor/inventory_rf_brigandine_armor.png";
		this.m.Icon = "armor/icon_rf_brigandine_armor.png";
	}
});
