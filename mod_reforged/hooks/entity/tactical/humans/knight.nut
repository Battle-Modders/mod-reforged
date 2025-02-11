::Reforged.HooksMod.hook("scripts/entity/tactical/humans/knight", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Knight);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_mentor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
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
				[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"],
				[1, "scripts/items/weapons/noble_sword"]
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
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/coat_of_plates"],
				[1, "scripts/items/armor/coat_of_scales"]
			]).roll()));
		}

		local bodyItem = this.getBodyItem();
		if (bodyItem != null && !bodyItem.isItemType(::Const.Items.ItemType.Named) && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier2)
		{
			local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
					if (conditionModifier < 30) return 0.0;
					return _weight;
				}
			})

			if (armorAttachment != null)
				bodyItem.setUpgrade(::new(armorAttachment));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/full_helm"],
				[1, "scripts/items/helmets/rf_visored_bascinet"],
				[1, "scripts/items/helmets/faction_helm"]
			]).roll();

			local helmet = ::new(script);
			if (script == "scripts/items/helmets/faction_helm")
				helmet.setVariant(banner);

			this.m.Items.equip(helmet);
		}
	}

	q.onSpawned = @() function()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		}
	}

	q.makeMiniboss = @() function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 25)
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_axe"],
				[1, "scripts/items/weapons/named/named_sword"],
				[1, "scripts/items/weapons/named/named_warhammer"],
				[1, "scripts/items/weapons/named/named_mace"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 50)
		{
			this.m.Items.equip(::new("scripts/items/" + ::Const.Items.NamedShields[::Math.rand(0, ::Const.Items.NamedShields.len() - 1)]));
		}
		else if (r <= 75)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 260) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}
		else
		{
			local helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 265) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		return true;
	}
});
