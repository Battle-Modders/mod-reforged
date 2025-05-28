::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_billman", function(q) {
	q.m.SurcoatChance <- 100;	// Chance for this character to spawn with a cosmetic tabard of its faction

	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Billman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
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
				[1, "scripts/items/weapons/billhook"],
				[1, "scripts/items/weapons/pike"],
				[1, "scripts/items/weapons/rf_poleflail"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/gambeson"],
				[1, "scripts/items/armor/basic_mail_shirt"],
				[1, "scripts/items/armor/mail_shirt"]
			]).roll();

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

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet;
			if (::Math.rand(1, 100) <= 75)
			{
				if (banner <= 4)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/kettle_hat"],
						[1, "scripts/items/helmets/padded_kettle_hat"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
				else if (banner <= 7)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/flat_top_helmet"],
						[1, "scripts/items/helmets/padded_flat_top_helmet"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
				else
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/nasal_helmet"],
						[1, "scripts/items/helmets/padded_nasal_helmet"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/aketon_cap"],
					[1, "scripts/items/helmets/full_aketon_cap"]
				]).roll());
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this);
		}
	}}.onSpawned;
});
