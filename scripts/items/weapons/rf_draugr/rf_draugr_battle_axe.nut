this.rf_draugr_battle_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_battle_axe";
		this.m.Name = "Barrowkin Battle Axe";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.Variant = ::Math.rand(1, 3);
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
		this.m.IconLarge = "weapons/melee/rf_draugr_battle_axe_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_draugr_battle_axe_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_draugr_battle_axe_" + variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		local weapon = this;

		this.addSkill(::Reforged.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 2;
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_man", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
