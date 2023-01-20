this.rf_named_battle_axe <- ::inherit("scripts/items/weapons/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.rf_named_battle_axe";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.Description = "A master smith has ensured that this axe sings as it swings, with pristine finishing to match.";
		this.m.ArmamentIcon = "icon_goblin_weapon_05"; // remove when placeholder art is replaced
		this.m.Value = 4000
		this.m.BaseWeaponScript = "scripts/items/weapons/rf_battle_axe";
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_named_battle_axe_0" + this.m.Variant + ".png"; // placeholder for named Battle Axe art
		this.m.Icon = "weapons/melee/rf_named_battle_axe_0" + this.m.Variant + "_70x70.png"; // placeholder for named Battle Axe art
		//this.m.ArmamentIcon = "icon_rf_estoc_named_0" + this.m.Variant; // need to replace with proper battle axe art.
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
			o.m.FatigueCost += 3;
		}));
	}
});
