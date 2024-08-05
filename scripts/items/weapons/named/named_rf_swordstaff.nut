this.named_rf_swordstaff <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = ::Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.named_rf_swordstaff";
		this.m.NameList = ::Const.Strings.SpetumNames;
		this.m.Description = "A well-crafted Swordstaff as beautiful as it is deadly. This masterpiece would make a welcome addition to any mercenary company";
		this.m.Value = 4200;
		this.m.BaseItemScript = "scripts/items/weapons/rf_swordstaff";
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

		this.addSkill(::new("scripts/skills/actives/overhead_strike"));

		local prong = ::new("scripts/skills/actives/prong_skill");
		prong.m.IsIgnoredAsAOO = true;
		this.addSkill(prong);

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
