this.rf_pole_flail <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_pole_flail";
		this.m.Name = "Pole Flail";
		this.m.Description = "A farmer's implement adapted for war, this weapon allows quick attacks from a safe distance.";
		this.m.IconLarge = "weapons/melee/rf_pole_flail_01.png";
		this.m.Icon = "weapons/melee/rf_pole_flail_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_rf_pole_flail_01";
		this.m.Value = 1400;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
		this.m.Reach = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/flail", function(o) {
			o.m.MaxRange = 2;
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lash", function(o) {
			o.m.MaxRange = 2;
			o.m.FatigueCost += 5;
		}));
	}
});
