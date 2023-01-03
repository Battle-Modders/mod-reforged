::mods_hookExactClass("entity/tactical/humans/desert_devil", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DesertDevil);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/adrenaline_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_kata", function(o) {o.m.IsForceEnabled = true;}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_vigorous_assault"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
		local weapon = this.getMainhandItem();

		if (weapon != null && weapon.isWeaponType(this.Const.Items.ItemType.OneHanded))
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}

		else
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_clarity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_sweeping_strikes"));
		}
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.BaseProperties.DamageDirectMult *= 0.8; //Reverts 1.25 bonus from vanilla
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fresh_and_furious"));

			local mainhandItem = this.getMainhandItem();
			if (mainhandItem != null && mainhandItem.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_double_strike"));
			}

			else
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			}

			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			}
		}

		return ret;
	}
});
