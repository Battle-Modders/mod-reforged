::Reforged.HooksMod.hook("scripts/entity/tactical/humans/caravan_guard", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.CaravanGuard);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/boar_spear"],
				[1, "scripts/items/weapons/falchion"],
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/scramasax"]
			]).roll();
			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag) && ::Math.rand(1, 100) <= 35)
		{
			local throwing = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/throwing_axe"],
				[1, "scripts/items/weapons/javelin"]
			]).roll();

			this.m.Items.addToBag(::new(throwing));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/gambeson"],
				[1, "scripts/items/armor/padded_leather"],
				[1, "scripts/items/armor/leather_lamellar"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.getBodyItem() != null)
		{
			if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier2)
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
			local helmet = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/aketon_cap"],
				[1, "scripts/items/helmets/full_aketon_cap"],
				[1, "scripts/items/helmets/mail_coif"],
				[1, "scripts/items/helmets/nasal_helmet"],
				[1, "scripts/items/helmets/dented_nasal_helmet"]
			]).roll();
			this.m.Items.equip(::new(helmet));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
	}}.onSpawned;
});
