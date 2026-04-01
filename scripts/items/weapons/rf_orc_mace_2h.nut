this.rf_orc_mace_2h <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_orc_mace_2h";
		this.m.Name = "Skull Crusher";
		this.m.Description = "A huge length of wood with a lot of metal scrap crudely nailed to its head. Too heavy to be used effectively by the average human.";
		this.m.Variant = ::Math.rand(1, 2);
		this.updateVariant();
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Mace;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 1500;
		this.m.ShieldDamage = 36;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -45;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 115;
		this.m.ArmorDamageMult = 1.35;
		this.m.DirectDamageMult = 0.5;
		this.m.FatigueOnSkillUse = 5;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.IconLarge = "weapons/melee/rf_orc_mace_2h_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_orc_mace_2h_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_orc_mace_2h_" + variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill;
		skill = ::new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_133.png";
		skill.m.IconDisabled = "skills/active_133_sw.png";
		skill.m.Overlay = "active_133";
		this.addSkill(skill);
		skill = ::new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_134.png";
		skill.m.IconDisabled = "skills/active_134_sw.png";
		skill.m.Overlay = "active_134";
		this.addSkill(skill);
		skill = ::new("scripts/skills/actives/split_shield");
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}
});
