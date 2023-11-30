this.rf_visored_bascinet <- ::inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_visored_bascinet";
		this.m.Name = "Visored Bascinet";
		this.m.Description = "A large bascinet with an attached visor and a foldable mouthpiece.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 1;
		this.m.VariantString = "rf_visored_bascinet"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4500;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -19;
		this.m.Vision = -3;
	}
});
