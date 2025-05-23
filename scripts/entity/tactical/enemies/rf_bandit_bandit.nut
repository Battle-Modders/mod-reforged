this.rf_bandit_bandit <- ::inherit("scripts/entity/tactical/human", {
	m = {
		HasNet = false,
		IsRegularThrower = false,
		IsSpearThrower = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditBandit;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditBandit.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditBandit);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));

		this.m.HasNet = ::Math.rand(1, 3) == 3; // 33% chance
		this.m.IsRegularThrower = ::Math.rand(1, 2) == 2;  // 50% chance

		if (this.m.IsRegularThrower == false)
		{
			this.m.IsSpearThrower = ::Math.rand(1, 4) == 4; // 25% chance. only rolled if not regular thrower.
		}
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
				"scripts/items/weapons/rondel_dagger",
				"scripts/items/weapons/arming_sword",
				"scripts/items/weapons/scramasax",
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)) // both hands free
			{
				weapons.addMany(1, [
					"scripts/items/weapons/rf_poleflail",
					"scripts/items/weapons/pike",
					"scripts/items/weapons/spetum",
					"scripts/items/weapons/warbrand"
				]);
			}

			this.m.Items.equip(::new(weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag))
		{
			if (this.m.IsRegularThrower)
			{
				local throwingWeapon = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/javelin"],
					[1, "scripts/items/weapons/throwing_axe"]
				]).roll();

				this.m.Items.addToBag(::new(throwingWeapon));
			}
			else if (this.m.IsSpearThrower)
			{
				this.m.Items.addToBag(::new("scripts/items/weapons/throwing_spear"));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax <= 70 || conditionMax > 100) return 0.0;
					return _weight;
				}
			})

			if (armor != null)
			{
				this.m.Items.equip(::new(armor));

				if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
				{
					local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
						Apply = function ( _script, _weight )
						{
							local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
							if (conditionModifier > 20) return 0.0;
							return _weight;
						}
					})

					if (armorAttachment != null)
						this.getBodyItem().setUpgrade(::new(armorAttachment));
				}
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 40 || conditionMax > 90) return 0.0;
					if (conditionMax > 70) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				// this.m.Skills.add(::new("scripts/skills/perks/perk_rf_cheap_trick"));	TODO: Enable once AI behavior is implemented
				this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
			}
		}
		switch (mainhandItem.getID())
		{
			case "weapon.pike":
				this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				break;
		}

		if (this.m.IsRegularThrower || this.m.IsSpearThrower)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}
});
