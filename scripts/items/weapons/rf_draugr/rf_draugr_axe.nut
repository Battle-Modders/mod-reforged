this.rf_draugr_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_axe";
		this.m.Name = "Barrowkin Axe";
		this.m.Description = "A heavy and worn axe from an ancient civilization decorated with the claws of some beast.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.Value = 800;
		this.m.ShieldDamage = 14;
		this.m.Condition = 76.0;
		this.m.ConditionMax = 76.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = 0.05;
		this.m.Reach = 3;

		this.m.Variant = ::Math.rand(1, 2);
		this.updateVariant();
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
