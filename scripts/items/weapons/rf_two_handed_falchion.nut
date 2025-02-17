this.rf_two_handed_falchion <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_two_handed_falchion";
		this.m.Name = "Two-Handed Falchion";
		this.m.Description = "A larger variant of the falchion that can deliver deep and deadly cuts.";
		this.m.IconLarge = "weapons/melee/rf_two_handed_falchion_01.png";
		this.m.Icon = "weapons/melee/rf_two_handed_falchion_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_two_handed_falchion_01";
		this.m.Value = 1700;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
		this.m.Reach = 4;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
