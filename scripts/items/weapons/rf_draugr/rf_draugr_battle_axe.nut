this.rf_draugr_battle_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_draugr_battle_axe";
		this.m.Name = "Barrowkin Battle Axe";
		this.m.Description = "This ornamented axe has a small head and long haft for quick and damaging blows. The metalwork is otherwise crude.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.Variant = ::Math.rand(1, 3);
		this.updateVariant();
		this.m.Value = 1650;
		this.m.ShieldDamage = 24;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.35;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 5;
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
