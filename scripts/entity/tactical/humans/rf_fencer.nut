this.rf_fencer <- ::inherit("scripts/entity/tactical/human" {
	m = {
		SurcoatChance = 100		// Chance for this character to spawn with a cosmetic tabard of its faction
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_Fencer;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_Fencer.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_military_fencer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_Fencer);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fencer"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= this.m.SurcoatChance)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/fencing_sword"],
				[1, "scripts/items/weapons/rf_estoc"]
			]).roll()));
		}

		if (this.m.IsMiniboss)
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new("scripts/items/armor/noble_mail_armor"));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new("scripts/items/helmets/greatsword_hat"));
			}
		}
		else
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/basic_mail_shirt"],
					[1, "scripts/items/armor/mail_shirt"],
					[1, "scripts/items/armor/leather_scale_armor"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 20)
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/headscarf"],
					[1, "scripts/items/helmets/aketon_cap"],
					[1, "scripts/items/helmets/full_aketon_cap"],
					[1, "scripts/items/helmets/greatsword_hat"]
				]).roll()));
			}
		}

		local bodyItem = this.getBodyItem();
		if (bodyItem != null && !bodyItem.isItemType(::Const.Items.ItemType.Named) && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier4)
		{
			bodyItem.setUpgrade(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor_upgrades/direwolf_pelt_upgrade"],
				[2, "scripts/items/armor_upgrades/leather_shoulderguards_upgrade"],
				[2, "scripts/items/armor_upgrades/double_mail_upgrade"]
			]).roll()));
		}
	}

	function onSpawned()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 40)
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_fencing_sword"],
				[1, "scripts/items/weapons/named/named_rf_estoc"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 70)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if ( conditionMax > 165) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}
		else
		{
			local helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 145) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));

		return true;
	}
});
