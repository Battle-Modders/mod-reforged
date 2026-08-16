::Reforged.HooksMod.hook("scripts/items/weapons/estoc", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.RF_Fencing;
		this.m.Categories = "Sword, Two-Handed";
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
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_sword_thrust_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/skewer_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}}.onEquip;
});
