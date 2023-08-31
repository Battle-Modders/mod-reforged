this.rf_padded_skull_cap_with_rondels <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_padded_skull_cap_with_rondels";
		this.m.Name = "Padded Skull Cap with Rondels";
		this.m.Description = "A skull cap with rondels overlaying a padded aketon hat.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 0;
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1500;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -8;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "rf_padded_skull_cap_with_rondels";
		this.m.SpriteDamaged = "rf_padded_skull_cap_with_rondels_damaged";
		this.m.SpriteCorpse = "rf_padded_skull_cap_with_rondels_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_rf_padded_skull_cap_with_rondels.png";
	}
});
