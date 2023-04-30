this.rf_padded_skull_cap <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_padded_skull_cap";
		this.m.Name = "Padded Skull Cap";
		this.m.Description = "A skull cap over aketon padding that provides strong protection, albiet with lackluster coverage.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1000;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -5;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_padded_skull_cap";
		this.m.SpriteDamaged = "rf_padded_skull_cap_damaged";
		this.m.SpriteCorpse = "rf_padded_skull_cap_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_padded_skull_cap.png";
	}
});
