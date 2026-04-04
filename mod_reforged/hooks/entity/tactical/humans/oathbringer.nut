::Reforged.HooksMod.hook("scripts/entity/tactical/humans/oathbringer", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Oathbringer);
		b.TargetAttractionMult = 1.0;
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
		this.getSprite("socket").setBrush("bust_base_military");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_lone_wolf"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
	}}.onInit;

	q.assignRandomEquipment = @() { function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer().addMany(1, [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			]);

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.addMany(1, [
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/two_handed_hammer",
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail",
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(::new("scripts/items/" + weapons.roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && ::Math.rand(1, 100) <= 60)
		{
			local shield = ::MSU.Class.WeightedContainer().addMany(1, [
				"shields/heater_shield"
			]).roll();
			this.m.Items.equip(::new("scripts/items/" + shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::MSU.Class.WeightedContainer().addMany(1, [
				"armor/adorned_heavy_mail_hauberk"
			]).roll();
			this.m.Items.equip(::new("scripts/items/" + armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::MSU.Class.WeightedContainer().addMany(1, [
				"helmets/adorned_closed_flat_top_with_mail",
				"helmets/adorned_closed_flat_top_with_mail",
				"helmets/adorned_full_helm",
				"helmets/adorned_full_helm",
				"helmets/full_helm"
			]);
			this.m.Items.equip(::new("scripts/items/" + helmet));
		}
	}}.assignRandomEquipment;

	q.onSpawned = @(__original) { function onSpawned()
	{
		__original();

		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

			if (::Reforged.Items.isDuelistValid(weapon))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
			}
		}
	}}.onSpawned;

	q.makeMiniboss = @(__original) { function makeMiniboss()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.fearsome"); // revert vanilla

			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bulwark"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
		}

		return ret;
	}}.makeMiniboss;
});
