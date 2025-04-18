this.rf_greatsword <- ::inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_greatsword";
		this.m.Name = "Greatsword";
		this.m.Description = "A long two-handed blade as good for crushing as for cutting.";
		this.m.IconLarge = "weapons/melee/sword_two_hand_01.png";
		this.m.Icon = "weapons/melee/sword_two_hand_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.ArmamentIcon = "icon_sword_two_handed_01";
		this.m.Value = 2400;
		this.m.ShieldDamage = 16;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 10;
		this.m.Reach = 6;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/overhead_strike", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 3;
			o.setStunChance(this.m.StunChance);
		}.bindenv(this)));

		this.addSkill(::Reforged.new("scripts/skills/actives/split", function(o) {
			o.m.FatigueCost -= 5;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/swing", function(o) {
			o.m.FatigueCost -= 5;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
		}));
	}
});
