this.rf_bandit_highwayman <- ::inherit("scripts/entity/tactical/human", {
	m = {
		IsThrower = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditHighwayman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditHighwayman.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditHighwayman);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));

		this.m.IsThrower = ::Math.rand(1, 4) <= 3; // 75% chance
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{

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
		        local twoHandedWeapons = ::MSU.Class.WeightedContainer().addMany(1, [
		            "scripts/items/weapons/billhook",
		            "scripts/items/weapons/pike",
		            "scripts/items/weapons/rf_poleflail",
		            "scripts/items/weapons/spetum"
		        ]);

		        // We set the total weight of 2-handed weapons to be double
		        // that of the total weight of 1-handed weapons. Because we want
		        // twice the chance of a 2h weapon compared to 1h.
		        local weightPerTwoHanded = (weapons.len() * 2.0) / twoHandedWeapons.len();
		        twoHandedWeapons.apply(@(_item, _weight) weightPerTwoHanded);

		        weapons.merge(twoHandedWeapons);
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

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/tools/throwing_net"))
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax <= 100 || conditionMax > 140) return 0.0;
					return _weight;
				}
			});

			if (armor != null)
			{
				this.m.Items.equip(::new(armor));

				if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier4)
				{
					local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
						Apply = function ( _script, _weight )
						{
							local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
							if (conditionModifier > 20) return 0.0;
							return _weight;
						}
					});

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
					if (conditionMax <= 90 || conditionMax > 130) return 0.0;
					return _weight;
				}
			});
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSpawned()
	{
		local offhandItem = this.getOffhandItem();

		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Tool)) // net
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_angler"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				// this.m.Skills.add(::new("scripts/skills/perks/perk_rf_cheap_trick"));	TODO: Enable once AI behavior is implemented
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
			}
			switch (weapon.getID())
			{
				case "weapon.pike":
					this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));
					break;
			}

			if (::Reforged.Items.isDuelistValid(weapon))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
		}

		if (this.m.IsThrower)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_opportunist"));
		}
	}
});
