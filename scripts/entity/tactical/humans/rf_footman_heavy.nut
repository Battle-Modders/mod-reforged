this.rf_footman_heavy <- ::inherit("scripts/entity/tactical/human" {
	m = {
		SurcoatChance = 100		// Chance for this character to spawn with a cosmetic tabard of its faction
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_FootmanHeavy;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_FootmanHeavy.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_FootmanHeavy);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
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
				[1, "scripts/items/weapons/military_pick"],
				[1, "scripts/items/weapons/arming_sword"],
				[1, "scripts/items/weapons/flail"],
				[1, "scripts/items/weapons/morning_star"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/faction_kite_shield"],
				[1, "scripts/items/shields/faction_heater_shield"]
			]).roll());

			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/mail_hauberk"],
				[1, "scripts/items/armor/footman_armor"],
				[1, "scripts/items/armor/reinforced_mail_hauberk"]
			]).roll();

			local armor = ::new(script);
			if (script == "scripts/items/armor/mail_hauberk")
				armor.setVariant(28);

			this.m.Items.equip(armor);

			if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier2)
			{
				local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
						if (conditionModifier < 20 || conditionModifier > 30) return 0.0;
						return _weight;
					}
				})

				if (armorAttachment != null)
					armor.setUpgrade(::new(armorAttachment));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet;
			if (banner <= 4)
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/kettle_hat_with_mail"],
					[1, "scripts/items/helmets/rf_skull_cap_with_mail"],
					[0.5, "scripts/items/helmets/rf_sallet_helmet_with_mail"]
				]).roll());
			}
			else if (banner <= 7)
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/flat_top_with_mail"],
					[1, "scripts/items/helmets/rf_skull_cap_with_mail"],
					[0.5, "scripts/items/helmets/rf_sallet_helmet_with_mail"]
				]).roll());
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/nasal_helmet_with_closed_mail"],
					[1, "scripts/items/helmets/rf_skull_cap_with_mail"],
					[0.5, "scripts/items/helmets/rf_sallet_helmet_with_mail"]
				]).roll());
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
	}

	function onSpawned()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
	}
});
