this.rf_draugr_greataxe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_greataxe";
		this.m.Name = "Barrowkin Greataxe";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.IconLarge = "weapons/melee/rf_draugr_greataxe_01.png";
		this.m.Icon = "weapons/melee/rf_draugr_greataxe_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_draugr_greataxe_01";
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
		local skill = ::new("scripts/skills/actives/split_man");
		skill.m.Icon = "skills/active_187.png";
		skill.m.IconDisabled = "skills/active_187_sw.png";
		skill.m.Overlay = "active_187";
		this.addSkill(skill);
		local skill = ::new("scripts/skills/actives/round_swing");
		skill.m.Icon = "skills/active_188.png";
		skill.m.IconDisabled = "skills/active_188_sw.png";
		skill.m.Overlay = "active_188";
		this.addSkill(skill);
		skill = ::new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}
});
