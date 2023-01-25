this.named_rf_swordstaff <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.named_rf_swordstaff";
		this.m.NameList = this.Const.Strings.SpetumNames;
		this.m.Description = "A well-crafted Swordstaff as beautiful as it is deadly. This masterpiece would make a welcome addition to any mercenary company";
		this.m.Value = 4200;
		this.m.BaseWeaponScript = "scripts/items/weapons/rf_swordstaff";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_swordstaff_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_swordstaff_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_swordstaff_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip()

		local prong = ::MSU.new("scripts/skills/actives/prong_skill", function(o) {
			o.m.FatigueCost += 2;
		});

		this.addSkill(prong);

		this.addSkill(::MSU.new("scripts/skills/actives/overhead_strike", function(o) {
			o.m.FatigueCost += 2;
			o.m.IsIgnoredAsAOO = true;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
