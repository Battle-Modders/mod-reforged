this.named_rf_poleaxe <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_poleaxe";
		this.m.NameList = ::Const.Strings.SpetumNames;
		this.m.Description = "This fine poleaxe is built for piercing mail and caving in helmets. It is the work of a mastersmith who knew the demands of battle.";
		this.m.Value = 4200;
		this.m.BaseItemScript = "scripts/items/weapons/rf_poleaxe";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_poleaxe_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_poleaxe_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_poleaxe_named_0" + this.m.Variant;
	}

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
