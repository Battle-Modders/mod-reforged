this.rf_reinforced_wooden_poleflail <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_reinforced_wooden_poleflail";
		this.m.Name = "Reinforced Wooden Poleflail";
		this.m.Description = "A long-handled farmer's implement reinforced to be sturdier in battle.";
		this.m.IconLarge = "weapons/melee/rf_reinforced_wooden_poleflail_01.png";
		this.m.Icon = "weapons/melee/rf_reinforced_wooden_poleflail_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Flail;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ItemProperty = ::Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.ArmamentIcon = "icon_rf_reinforced_wooden_poleflail_01";
		this.m.Value = 700;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.StaminaModifier = -12;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_flail_pole_skill", function(o) {
			o.m.FatigueCost -= 2;
		}));
		this.addSkill(::Reforged.new("scripts/skills/actives/rf_lash_pole_skill", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
