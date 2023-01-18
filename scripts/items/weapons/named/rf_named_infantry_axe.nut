this.rf_named_infantry_axe <- ::inherit("scripts/items/weapons/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.rf_infantry_axe";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.Description = "A master smith has ensured that this axe sings as it swings, with pristine finishing to match.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_goblin_weapon_05"; // remove when placeholder art is replaced
		this.m.Value = 4000
		this.m.ShieldDamage = 24;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.35;
		this.m.Reach = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_named_infantry_axe_0" + this.m.Variant + ".png"; // placeholder for named Infantry Axe art
		this.m.Icon = "weapons/melee/rf_named_infantry_axe_0" + this.m.Variant + "_70x70.png"; // placeholder for named Infantry Axe art
		//this.m.ArmamentIcon = "icon_rf_estoc_named_0" + this.m.Variant; // need to replace with proper infantry axe art.
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
			skillToAdd.setApplyAxeMastery(true);
			o.m.FatigueCost += 3;
		}));
});
