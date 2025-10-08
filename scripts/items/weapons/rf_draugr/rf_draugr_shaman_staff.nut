this.rf_draugr_shaman_staff <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_shaman_staff";
		this.m.Name = "Barrow Seer\'s Staff";
		this.m.Description = "This highly ornamented, ram-skulled staff suggests a culture with strong ritualistic beliefs.";
		this.m.IconLarge = "weapons/melee/rf_draugr_shaman_staff_01.png";
		this.m.Icon = "weapons/melee/rf_draugr_shaman_staff_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Mace;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_draugr_shaman_staff_01";
		this.m.Value = 1500;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local skill;
		skill = ::new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_178.png";
		skill.m.IconDisabled = "skills/active_178_sw.png";
		skill.m.Overlay = "active_178";
		skill.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skill);
		skill = ::new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_179.png";
		skill.m.IconDisabled = "skills/active_179_sw.png";
		skill.m.Overlay = "active_179";
		skill.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skill);
	}
});
