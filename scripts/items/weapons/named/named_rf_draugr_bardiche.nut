this.named_rf_draugr_bardiche <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_draugr_bardiche";
		this.m.NameList = ::Const.Strings.AxeNames;
		this.m.Description = "This ancient bardiche features a large ornamented blade that is built for war and strikes with the weight of a weapon made to end fights quickly.";
		this.m.Value = 4600;
		this.m.BaseItemScript = "scripts/items/weapons/bardiche";
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant >= 10 ? this.m.Variant : "0" + this.m.Variant;
		this.m.IconLarge = "weapons/melee/rf_draugr_bardiche_named_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_draugr_bardiche_named_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_draugr_bardiche_named_" + variant;
	}

	// Modular Vanilla function
	// TODO: Adjust direct damage and armor damage
	function setValuesBeforeRandomize( _baseItem )
	{
		this.weapon.setValuesBeforeRandomize(_baseItem);
	}
});
