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
		this.m.BaseWeaponScript = "scripts/items/weapons/rf_battle_axe";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_battle_axe_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_battle_axe_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_battle_axe_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local weapon = this;

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 2;
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
