this.rf_battle_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_battle_axe";
		this.m.Name = "Battle Axe";
		this.m.Description = "A two-handed axe designed for versatile strikes.";
		this.m.IconLarge = "weapons/melee/rf_battle_axe_01.png";
		this.m.Icon = "weapons/melee/rf_battle_axe_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_rf_battle_axe_01";
		this.m.Value = 1950;
		this.m.ShieldDamage = 26;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.35;
		this.m.Reach = 5;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
