this.rf_poleaxe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_poleaxe";
		this.m.Name = "Poleaxe";
		this.m.Description = "A versatile and formidable weapon with a long shaft, an axe head and a spear point making it an ideal choice for both close and long range melee combat.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/rf_poleaxe_01.png";
		this.m.Icon = "weapons/melee/rf_poleaxe_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.ArmamentIcon = "icon_rf_poleaxe_01";
		this.m.Value = 2800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/impale", function(o) {
			o.m.Icon = "skills/rf_poleaxe_impale_skill.png";
			o.m.IconDisabled = "skills/rf_poleaxe_impale_skill_sw.png";
			o.m.Overlay = "rf_poleaxe_impale_skill";
			o.m.IsIgnoredAsAOO = true;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/strike_skill", function(o) {
			o.setApplyAxeMastery(true);
			o.m.Icon = "skills/rf_poleaxe_strike_skill.png";
			o.m.IconDisabled = "skills/rf_poleaxe_strike_skill_sw.png";
			o.m.Overlay = "rf_poleaxe_strike_skill";
			o.m.IsIgnoredAsAOO = true;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/chop", function(o) {
			o.m.Name = "Hew";
			o.m.ActionPointCost = 6;
			o.m.FatigueCost = 15;
			o.m.Icon = "skills/rf_poleaxe_hew_skill.png";
			o.m.IconDisabled = "skills/rf_poleaxe_hew_skill_sw.png";
			o.m.Overlay = "rf_poleaxe_hew_skill";
		}));
	}
});
