this.rf_draugr_voulge <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_voulge";
		this.m.Name = "Barrowkin Long Blade";
		this.m.Description = "A heavy chopping blade on the end of a long pole meant for hacking at a distance.";
		this.m.IconLarge = "weapons/melee/rf_draugr_voulge_01.png";
		this.m.Icon = "weapons/melee/rf_draugr_voulge_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_draugr_voulge_01";
		this.m.Value = 2400;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 10;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local weapon = this;
		this.addSkill(::new("scripts/skills/actives/rf_voulge_cleave_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_gouge_skill", function(o) {
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));
	}
});
