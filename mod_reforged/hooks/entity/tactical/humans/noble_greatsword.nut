::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_greatsword", function(q) {
	q.m.SurcoatChance <- 100;	// Chance for this character to spawn with a cosmetic tabard of its faction

	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Greatsword);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
	}

	q.assignRandomEquipment = @() function()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= this.m.SurcoatChance)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/greatsword"));
		}

		if (this.m.IsMiniboss)
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/rf_brigandine_harness"],
					[1, "scripts/items/armor/rf_breastplate_armor"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_padded_sallet_helmet"],
					[1, "scripts/items/helmets/barbute_helmet"],
					[1, "scripts/items/helmets/rf_half_closed_sallet"]
				]).roll()));
			}
		}
		else
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/reinforced_mail_hauberk"],
					[1, "scripts/items/armor/scale_armor"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				local helmet = ::new("scripts/items/helmets/greatsword_faction_helm");
				helmet.setVariant(banner);
				this.m.Items.equip(helmet);
			}
		}

		local bodyItem = this.getBodyItem();
		if (bodyItem != null && !bodyItem.isItemType(::Const.Items.ItemType.Named) && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier4)
		{
			local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
					if (conditionModifier > 40) return 0.0;
					return _weight;
				}
			});

			if (armorAttachment != null)
				bodyItem.setUpgrade(::new(armorAttachment));
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
		if (r <= 40)
		{
			this.m.Items.equip(::new("scripts/items/weapons/named/named_greatsword"));
		}
		else if (r <= 70)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 205 || conditionMax > 270) return 0.0;
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
					if (conditionMax < 200 || conditionMax > 270) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));

		return true;
	}
});
