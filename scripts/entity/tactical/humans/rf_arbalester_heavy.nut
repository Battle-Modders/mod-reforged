this.rf_arbalester_heavy <- ::inherit("scripts/entity/tactical/human" {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ArbalesterHeavy;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_ArbalesterHeavy.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ArbalesterHeavy);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		b.Vision = 8;

		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_entrenched"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 80)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/heavy_crossbow"));
			this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
		}

		this.m.Items.addToBag(::new("scripts/items/weapons/rondel_dagger"));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/leather_lamellar"],
				[1, "scripts/items/armor/basic_mail_shirt"],
				[1, "scripts/items/armor/mail_shirt"]
			]).roll();

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
					})

					if (armorAttachment != null)
						this.getBodyItem().setUpgrade(::new(armorAttachment));
				}
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/full_aketon_cap"],
				[1, "scripts/items/helmets/mail_coif"],
				[1, "scripts/items/helmets/rf_skull_cap"],
				[1, "scripts/items/helmets/closed_mail_coif"]
			]).roll());

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
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
});
