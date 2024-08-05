this.rf_voulge <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_voulge";
		this.m.Name = "Voulge";
		this.m.Description = "A long shaft with a large blade attached at the end for delivering deep wounds from a distance.";
		this.m.IconLarge = "weapons/melee/rf_voulge_01.png";
		this.m.Icon = "weapons/melee/rf_voulge_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_voulge_01";
		this.m.Value = 1200;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local weapon = this;
		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.Icon = "skills/rf_voulge_cleave_skill.png";
			o.m.IconDisabled = "skills/rf_voulge_cleave_skill_sw.png";
			o.m.Overlay = "rf_voulge_cleave_skill";
			o.m.MaxRange = 2;
			o.m.ActionPointCost = 6;
			o.m.FatigueCost = 15;
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_gouge_skill", function(o) {
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));
	}
});
