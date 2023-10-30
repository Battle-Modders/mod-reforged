this.rf_vampire_lord_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.rf_vampire_lord_armor";
		this.m.Name = "Necrosavant Lord Chestpiece";
		this.m.Description = "An adorned chestpiece worn by Necrosavant Lords. Provides some protection.";
		this.m.SlotType = ::Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.VariantString = "rf_vampire_lord_armor";
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1000;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -5;
	}
});
