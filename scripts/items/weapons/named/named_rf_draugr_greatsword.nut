this.named_rf_draugr_greatsword <- ::inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_rf_draugr_greatsword";
		this.m.NameList = ::Const.Strings.GreatswordNames;
		this.m.Description = "A long-bladed sword lined with runes from an ancient civilization that despite its age maintains a keen edge. Has a bone handle construction seemingly as much for ornamentation as function.";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.Value = 3200;
		this.m.ShieldDamage = 24;
		this.m.Condition = 70.0;
		this.m.ConditionMax = 70.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 10;
		this.m.Reach = 6;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.IconLarge = "weapons/melee/rf_draugr_greatsword_named_" + variant + ".png";
		this.m.Icon = "weapons/melee/rf_draugr_greatsword_named_" + variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_rf_draugr_greatsword_named_" + variant ;
	}

	function onEquip()
	{
		this.__setNameBasedOnChampion();

		this.named_weapon.onEquip();

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

	function onPutIntoBag()
	{
		this.__setNameBasedOnChampion();
		this.named_weapon.onPutIntoBag();
	}

	function __setNameBasedOnChampion()
	{
		if (this.m.Name.len() == 0 && this.getContainer().getActor().getSkills().has("racial.champion"))
		{
			this.setName(this.getContainer().getActor().getName() + "\'s " + ::MSU.Array.rand(this.m.Name));
		}
	}
});
