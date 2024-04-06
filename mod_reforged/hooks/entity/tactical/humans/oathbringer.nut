::Reforged.HooksMod.hook("scripts/entity/tactical/humans/oathbringer", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Oathbringer);
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
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
	}

	q.assignRandomEquipment = @() function()
	{
	   	if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/two_handed_hammer"
				]);
			}

			if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 60)
		{
			local shields = [
				"shields/heater_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		// else
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		// }

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				"armor/adorned_heavy_mail_hauberk"
			];
			this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				"helmets/adorned_closed_flat_top_with_mail",
				"helmets/adorned_closed_flat_top_with_mail",
				"helmets/adorned_full_helm",
				"helmets/adorned_full_helm",
				"helmets/full_helm"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
		}

		// Reforged
		if (this.isArmedWithShield())
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}

		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (::Reforged.Items.isDuelistValid(weapon))
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
		else
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_man_of_steel"));
		}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.fearsome"); // revert vanilla

			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bulwark"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
		}

		return ret;
	}
});
