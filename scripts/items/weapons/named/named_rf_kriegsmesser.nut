this.named_rf_kriegsmesser <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_kriegsmesser";
		this.m.NameList = ::Const.Strings.RF_KriegsmesserNames;
		this.m.Description = "An exceptionally crafted great cleaver, well-balanced and deadly. Capable of delivering deep cuts, while moving nimbly like a sword.";
		this.m.Value = 3000;
		this.m.BaseItemScript = "scripts/items/weapons/rf_kriegsmesser";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_kriegsmesser_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_kriegsmesser_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_kriegsmesser_named_0" + this.m.Variant;
	}

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
