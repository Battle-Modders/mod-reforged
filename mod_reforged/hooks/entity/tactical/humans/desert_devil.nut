::Reforged.HooksMod.hook("scripts/entity/tactical/humans/desert_devil", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DesertDevil);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/adrenaline_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/footwork"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_kata", function(o) {o.m.IsForceEnabled = true;}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
			}
		}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.BaseProperties.DamageDirectMult *= 0.8; //Reverts 1.25 bonus from vanilla

			local mainhandItem = this.getMainhandItem();
			if (mainhandItem != null)
			{
				if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
				}
				else
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
				}
			}
		}

		return ret;
	}
});
