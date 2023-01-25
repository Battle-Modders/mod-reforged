this.named_rf_poleflail <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_poleflail";
		this.m.NameList = this.Const.Strings.TwoHandedFlailNames;
		this.m.Description = "Impossible to confuse for the agricultural tool it is based upon, the beautiful craftmanship of a master weaponsmith is clear to see.";
		this.m.Value = 4000;
		this.m.BaseWeaponScript = "scripts/items/weapons/rf_poleflail";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_poleflail_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_poleflail_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_poleflail_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip()

		this.addSkill(::MSU.new("scripts/skills/actives/flail_skill", function(o) {
			o.m.MaxRange = 2;
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lash_skill", function(o) {
			o.m.MaxRange = 2;
			o.m.FatigueCost += 5;
		}));
	}
});
