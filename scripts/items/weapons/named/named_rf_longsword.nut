this.named_rf_longsword <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_longsword";
		this.m.NameList = ::Const.Strings.RF_LongswordNames;
		this.m.Description = "This exquisite piece of craftsmanship has unrivaled quality. The blade sings as it swings through the air.";
		this.m.Value = 4000;
		this.m.BaseItemScript = "scripts/items/weapons/longsword";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_longsword_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_longsword_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_longsword_named_0" + this.m.Variant;
	}

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
