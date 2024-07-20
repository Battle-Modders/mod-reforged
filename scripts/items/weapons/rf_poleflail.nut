this.rf_poleflail <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_poleflail";
		this.m.Name = "Poleflail";
		this.m.Description = "A farmer's implement adapted for war, this weapon allows quick attacks from a safe distance.";
		this.m.IconLarge = "weapons/melee/rf_poleflail_01.png";
		this.m.Icon = "weapons/melee/rf_poleflail_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Flail;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ItemProperty = ::Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.ArmamentIcon = "icon_rf_poleflail_01";
		this.m.Value = 1400;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/rf_flail_pole_skill"));
		this.addSkill(::new("scripts/skills/actives/rf_lash_pole_skill"));
	}
});

