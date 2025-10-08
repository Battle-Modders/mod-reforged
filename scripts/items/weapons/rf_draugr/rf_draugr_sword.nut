this.rf_draugr_sword <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_sword";
		this.m.Name = "Ancestral Sword";
		this.m.Description = "An ancient and somewhat primitive one-handed sword decorated with animal teeth.";
		this.m.IconLarge = "weapons/melee/rf_draugr_sword_01.png";
		this.m.Icon = "weapons/melee/rf_draugr_sword_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.ArmamentIcon = "icon_rf_draugr_sword_01";
		this.m.Value = 1000;
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
		this.m.Reach = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/slash"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});
