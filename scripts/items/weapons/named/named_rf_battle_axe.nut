this.named_rf_battle_axe <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_battle_axe";
		this.m.NameList = ::Const.Strings.AxeNames;
		this.m.Description = "A master smith has ensured that this axe sings as it swings, with pristine finishing to match.";
		this.m.Value = 4000
		this.m.BaseItemScript = "scripts/items/weapons/rf_battle_axe";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_battle_axe_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_battle_axe_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_battle_axe_named_0" + this.m.Variant;
	}

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
