::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_arbalester", function(q) {
	q.m.SurcoatChance <- 100;	// Chance for this character to spawn with a cosmetic tabard of its faction

	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Arbalester);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		b.Vision = 8;

		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
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
			this.m.Items.equip(::new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
		}

		this.m.Items.addToBag(::new("scripts/items/weapons/dagger"));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/gambeson"],
				[1, "scripts/items/armor/padded_leather"],
				[1, "scripts/items/armor/leather_lamellar"]
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
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/aketon_cap"],
				[1, "scripts/items/helmets/full_aketon_cap"],
				[1, "scripts/items/helmets/mail_coif"],
				[1, "scripts/items/helmets/rf_skull_cap"]
			]).roll();

			if (script != "")
			{
				local helmet = ::new(script);
				helmet.setPlainVariant();
				this.m.Items.equip(helmet);
			}
		}
	}

	q.onSpawned = @() function()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
	}
});
