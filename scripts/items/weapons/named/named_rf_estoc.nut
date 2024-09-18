this.named_rf_estoc <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_estoc";
		this.m.NameList = ::Const.Strings.FencingSwordNames;
		this.m.Description = "A well-forged estoc requires length and strength while remaining light enough to be quick and nimble in the hand. This blade is one of the finest examples you have ever laid eyes on.";
		this.m.Value = 4200;
		this.m.BaseItemScript = "scripts/items/weapons/rf_estoc";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_estoc_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_estoc_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_estoc_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip()

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_sword_thrust_skill", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}
});
