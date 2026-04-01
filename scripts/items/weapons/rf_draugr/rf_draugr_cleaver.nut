this.rf_draugr_cleaver <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_cleaver";
		this.m.Name = "Barrowkin Cleaver";
		this.m.Description = "Ornamentation on this otherwise crude blade suggests a culture with reverence for that sort of thing.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.Variant = ::Math.rand(1, 3);
		this.updateVariant();
		this.m.Value = 650;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;
		this.m.Reach = 3;
	}

	function updateVariant()
	{
		local variant = this.m.Variant >= 10 ? this.m.Variant : "0" + this.m.Variant;
		this.m.IconLarge = "weapons/melee/rf_draugr_cleaver_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_draugr_cleaver_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_draugr_cleaver_" + variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = ::new("scripts/skills/actives/cleave");
		skill.m.Icon = "skills/active_182.png";
		skill.m.IconDisabled = "skills/active_182_sw.png";
		skill.m.Overlay = "active_182";
		this.addSkill(skill);
		this.addSkill(::new("scripts/skills/actives/decapitate"));
	}
});
