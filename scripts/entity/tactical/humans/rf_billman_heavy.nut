this.rf_billman_heavy <- ::inherit("scripts/entity/tactical/human" {
	m = {
		SurcoatChance = 100		// Chance for this character to spawn with a cosmetic tabard of its faction
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BillmanHeavy;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BillmanHeavy.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BillmanHeavy);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_rf_follow_up")); // Disabled due to crashing the game on a follow up kill
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
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
				[1, "scripts/items/weapons/rf_halberd"],
				[1, "scripts/items/weapons/polehammer"],
				[1, "scripts/items/weapons/rf_voulge"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/mail_hauberk"],
				[1, "scripts/items/armor/mail_shirt"],
				[1, "scripts/items/armor/light_scale_armor"]
			]).roll();

			if (script != null)
			{
				local armor = ::new(script);
				if (script == "scripts/items/armor/mail_hauberk")
					armor.setVariant(28);

				this.m.Items.equip(armor);

				if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
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
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet;
			if (::Math.rand(1, 100) <= 75)
			{
				if (banner <= 4)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/padded_kettle_hat"],
						[1, "scripts/items/helmets/kettle_hat_with_mail"],
						[1, "scripts/items/helmets/rf_padded_skull_cap"],
						[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
					]).roll());
				}
				else if (banner <= 7)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/padded_flat_top_helmet"],
						[1, "scripts/items/helmets/flat_top_with_mail"],
						[1, "scripts/items/helmets/rf_padded_skull_cap"],
						[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
					]).roll());
				}
				else
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/padded_nasal_helmet"],
						[1, "scripts/items/helmets/nasal_helmet_with_mail"],
						[1, "scripts/items/helmets/rf_padded_skull_cap"],
						[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
					]).roll());
				}
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/full_aketon_cap"],
					[1, "scripts/items/helmets/mail_coif"],
					[1, "scripts/items/helmets/rf_skull_cap"],
					[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
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
			if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
			}
			else // polehammer or voulge
			{
				::Reforged.Skills.addMasteryOfEquippedWeapon(this);
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
			}
		}
	}
});
