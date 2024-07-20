this.rf_estoc <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_estoc";
		this.m.Name = "Estoc";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.IconLarge = "weapons/melee/rf_estoc_01.png";
		this.m.Icon = "weapons/melee/rf_estoc_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.RF_Fencing;
		this.m.ArmamentIcon = "icon_rf_estoc_01";
		this.m.Value = 2400;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.35; // Brings the total to 60%
		this.m.ChanceToHitHead = -25;
		this.m.Reach = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rf_sword_thrust_skill", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
