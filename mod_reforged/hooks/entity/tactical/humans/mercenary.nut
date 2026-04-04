::Reforged.HooksMod.hook("scripts/entity/tactical/humans/mercenary", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Mercenary);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer([
				[1, "weapons/hand_axe"],
				[1, "weapons/fighting_spear"],
				[1, "weapons/morning_star"],
				[1, "weapons/falchion"],
				[1, "weapons/arming_sword"],
				[1, "weapons/flail"],
				[1, "weapons/military_pick"],
				[1, "weapons/three_headed_flail"],
				[1, "weapons/scimitar"]
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.addArray([
					[1, "weapons/billhook"],
					[1, "weapons/pike"],
					[1, "weapons/warbrand"],
					[1, "weapons/longsword"],
					[1, "weapons/polehammer"],
					[1, "weapons/bardiche"],
					[1, "weapons/rf_kriegsmesser"],
					[1, "weapons/rf_greatsword"]
				]);
			}

			this.m.Items.equip(::new("scripts/items/" + weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			if (::Math.rand(1, 100) <= 75)
			{
				local shields = ::MSU.Class.WeightedContainer([
					[1, "shields/wooden_shield"],
					[1, "shields/heater_shield"],
					[1, "shields/kite_shield"]
				]);

				this.m.Items.equip(::new("scripts/items/" + shields.roll()));
			}
			else
			{
				this.m.Items.equip(::new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag) && ::Math.rand(1, 100) <= 60)
		{
			local bag = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/throwing_axe"],
				[1, "scripts/items/weapons/javelin"],
				[1, "scripts/items/weapons/throwing_spear"]
			]);
			this.m.Items.equip(::new(bag.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/sellsword_armor"],
				[1, "scripts/items/armor/padded_leather"],
				[1, "scripts/items/armor/patched_mail_shirt"],
				[1, "scripts/items/armor/basic_mail_shirt"],
				[1, "scripts/items/armor/mail_shirt"],
				[1, "scripts/items/armor/reinforced_mail_hauberk"],
				[1, "scripts/items/armor/mail_hauberk"],
				[1, "scripts/items/armor/lamellar_harness"],
				[1, "scripts/items/armor/footman_armor"],
				[1, "scripts/items/armor/light_scale_armor"],
				[1, "scripts/items/armor/leather_scale_armor"],
			]);
			this.m.Items.equip(::new(armor.roll()));
		}

		if (this.getBodyItem() != null && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier4)
		{
			local armor = this.getBodyItem();
			local conditionMax = armor.getConditionMax();

			local conditionModifierCutoff = 40;
			if (conditionMax < 90)
				conditionModifierCutoff = 20;
			else if (conditionMax < 150)
				conditionModifierCutoff = 30;

			local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
					if (conditionModifier > conditionModifierCutoff) return 0.0;
					return _weight;
				}
			});

			if (armorAttachment != null)
			{
				armor.setUpgrade(::new(armorAttachment));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) <= 95)
		{
			local helmets = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/nasal_helmet"],
				[1, "scripts/items/helmets/nasal_helmet_with_mail"],
				[1, "scripts/items/helmets/mail_coif"],
				[1, "scripts/items/helmets/reinforced_mail_coif"],
				[1, "scripts/items/helmets/headscarf"],
				[1, "scripts/items/helmets/kettle_hat"],
				[1, "scripts/items/helmets/kettle_hat_with_mail"],
				[1, "scripts/items/helmets/flat_top_helmet"],
				[1, "scripts/items/helmets/flat_top_with_mail"],
				[1, "scripts/items/helmets/closed_flat_top_helmet"],
				[1, "scripts/items/helmets/closed_mail_coif"],
				[1, "scripts/items/helmets/bascinet_with_mail"],
				[1, "scripts/items/helmets/nordic_helmet"],
				[1, "scripts/items/helmets/steppe_helmet_with_mail"]
			]);

			this.m.Items.equip(::new(helmets.roll()));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @() { function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (::Reforged.Items.isDuelistValid(weapon))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}

		foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
		{
			if (item.isItemType(::Const.Items.ItemType.RangedWeapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
				break;
			}
		}
	}}.onSpawned;
});
