this.rf_draugr_sword_2h <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_sword_2h";
		this.m.Name = "Ancestral Sword";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.IconLarge = "weapons/melee/rf_draugr_sword_2h_01.png";
		this.m.Icon = "weapons/melee/rf_draugr_sword_2h_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_draugr_sword_2h_01";
		this.m.Value = 2400;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
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

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_sword_thrust_skill", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}
});
