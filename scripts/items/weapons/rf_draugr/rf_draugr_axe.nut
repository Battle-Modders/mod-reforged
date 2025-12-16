this.rf_draugr_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_axe";
		this.m.Name = "Barrowkin Axe";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.Variant = ::Math.rand(1, 2);
		this.updateVariant();
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

	function updateVariant()
	{
		local variant = this.m.Variant >= 10 ? this.m.Variant : "0" + this.m.Variant;
		this.m.IconLarge = "weapons/melee/rf_draugr_axe_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_draugr_axe_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_draugr_axe_" + variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = ::new("scripts/skills/actives/chop");
		skill.m.Icon = "skills/active_185.png";
		skill.m.IconDisabled = "skills/active_185_sw.png";
		skill.m.Overlay = "active_185";
		this.addSkill(skill);
		skill = ::new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}
});
