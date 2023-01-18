this.rf_named_estoc <- ::inherit("scripts/items/weapons/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.rf_named_estoc";
		this.m.NameList = this.Const.Strings.FencingSwordNames;
		this.m.Description = "A well-forged estoc requires length and strength while remaining light enough to be quick and nimble in the hand. This blade is one of the finest examples you have ever laid eyes on.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4200;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.2;
		this.m.Reach = 5;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/rf_estoc_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/rf_estoc_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_estoc_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rf_sword_thrust", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lunge"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
