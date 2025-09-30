::Reforged.HooksMod.hook("scripts/entity/tactical/humans/nomad_leader", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.NomadLeader);
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
		this.getSprite("socket").setBrush("bust_base_nomads");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect")); Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(::new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 40)
		// {
		// 	this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
		local rtt = this.m.Skills.getSkillByID("actives.rally_the_troops");
		if (rtt != null)
		{
			rtt.setBaseValue("ActionPointCost", 1);
			rtt.m.Cooldown = 3;
		}
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/fighting_spear"],
				[1, "scripts/items/weapons/oriental/heavy_southern_mace"],
				[1, "scripts/items/weapons/shamshir"],
				[1, "scripts/items/weapons/three_headed_flail"],
			]);
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.addArray([
					[1, "scripts/items/weapons/greataxe"],
					[1, "scripts/items/weapons/oriental/two_handed_scimitar"]
				]);
			}
			this.m.Items.equip(::new(weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag))
		{
			local throwing = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/javelin"],
				[1, "scripts/items/weapons/throwing_spear"]
			]).rollChance(33);

			if (throwing != null) this.m.Items.addToBag(::new(throwing));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(::new("scripts/items/shields/oriental/metal_round_shield"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/light_scale_armor"],
				[1, "scripts/items/armor/oriental/southern_long_mail_with_padding"],
				[1, "scripts/items/armor/lamellar_harness"]
			]).roll();
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/oriental/southern_helmet_with_coif"],
				[1, "scripts/items/helmets/steppe_helmet_with_mail"]
			]).roll();
			this.m.Items.equip(::new(helmet));
		}
	}}.assignRandomEquipment;

	q.makeMiniboss = @(__original) { function makeMiniboss()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.underdog");
			this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));
		}

		return ret;
	}}.makeMiniboss;

	q.onSpawned = @() { function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_line_breaker"));
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
