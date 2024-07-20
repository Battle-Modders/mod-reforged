this.rf_great_khopesh <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_great_khopesh";
		this.m.Name = "Great Khopesh";
		this.m.Description = "A long two-handed blade that can deal deep cuts and devastating blows.";
		this.m.IconLarge = "weapons/melee/rf_great_khopesh_01.png";
		this.m.Icon = "weapons/melee/rf_great_khopesh_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.ArmamentIcon = "icon_rf_great_khopesh_01";
		this.m.Value = 2800;
		this.m.ShieldDamage = 28;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05; // Brings the total to 30%
		this.m.ChanceToHitHead = 10;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/rf_great_cleave_skill"));
		this.addSkill(::new("scripts/skills/actives/rf_cleaving_split_skill"));
		this.addSkill(::new("scripts/skills/actives/rf_cleaving_swing_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
