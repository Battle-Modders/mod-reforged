::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_footman", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Footman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	}

	q.assignRandomEquipment = @() function()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 90)
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
				[1, "scripts/items/armor/mail_shirt"],
				[1, "scripts/items/armor/basic_mail_shirt"]
			]).roll();

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
						if (conditionModifier > 30) return 0.0;
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
					[1, "scripts/items/helmets/kettle_hat"],
					[1, "scripts/items/helmets/padded_kettle_hat"],
					[1, "scripts/items/helmets/rf_skull_cap"],
					[1, "scripts/items/helmets/rf_skull_cap_with_rondels"],
					[1, "scripts/items/helmets/rf_padded_skull_cap"],
					[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
				]).roll());
			}
			else if (banner <= 7)
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/flat_top_helmet"],
					[1, "scripts/items/helmets/padded_flat_top_helmet"],
					[1, "scripts/items/helmets/rf_skull_cap"],
					[1, "scripts/items/helmets/rf_skull_cap_with_rondels"],
					[1, "scripts/items/helmets/rf_padded_skull_cap"],
					[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
				]).roll());
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/nasal_helmet"],
					[1, "scripts/items/helmets/padded_nasal_helmet"],
					[1, "scripts/items/helmets/rf_skull_cap"],
					[1, "scripts/items/helmets/rf_skull_cap_with_rondels"],
					[1, "scripts/items/helmets/rf_padded_skull_cap"],
					[1, "scripts/items/helmets/rf_padded_skull_cap_with_rondels"]
				]).roll());
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
	}

	q.onSpawned = @() function()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}
});
