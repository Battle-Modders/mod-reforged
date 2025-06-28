this.named_rf_voulge <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = ::Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.named_rf_battle_axe";
		this.m.NameList = ::Const.Strings.AxeNames;
		this.m.Description = "This masterfully wrought voulge features a blade that is built for war and strikes with the weight of a weapon made to end fights quickly.";
		this.m.Value = 4000;
		this.m.BaseItemScript = "scripts/items/weapons/rf_voulge";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_voulge_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_voulge_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_voulge_named_0" + this.m.Variant;
	}

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
