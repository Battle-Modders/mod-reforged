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

	function onEquip()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.DirectDamageMult = this.m.DirectDamageMult;
			o.m.FatigueCost += 3;
		}.bindenv(this)));

		this.addSkill(::Reforged.new("scripts/skills/actives/overhead_strike", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}
});
