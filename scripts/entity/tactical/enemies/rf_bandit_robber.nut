this.rf_bandit_robber <- ::inherit("scripts/entity/tactical/human", {
	m = {
		HasNet = false,
		IsThrower = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditRobber;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditRobber.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_fast_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditRobber);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));

		this.m.HasNet = ::Math.rand(1, 5) == 5; // 20% chance
		this.m.IsThrower = ::Math.rand(1, 2) == 2; // 50% chance
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.HasNet && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/tools/throwing_net"))
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer().addMany(1, [
				"scripts/items/weapons/boar_spear",
				"scripts/items/weapons/dagger",
				"scripts/items/weapons/falchion",
				"scripts/items/weapons/scramasax",
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)) // both hands free
			{
				weapons.addMany(1, [
					"scripts/items/weapons/hooked_blade",
					"scripts/items/weapons/pike",
					"scripts/items/weapons/rf_reinforced_wooden_poleflail",
					"scripts/items/weapons/warfork"
				]);
			}

			this.m.Items.equip(::new(weapons.roll()));
		}

		if (this.m.IsThrower && this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag))
		{
			local throwingWeapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/javelin"],
				[1, "scripts/items/weapons/throwing_axe"]
			]).roll();

			this.m.Items.addToBag(::new(throwingWeapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 70) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 50) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
				this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_cheap_trick"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Polearm))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			}
			else
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
			}
		}
	}
});
