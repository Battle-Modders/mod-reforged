::Reforged.HooksMod.hook("scripts/entity/tactical/humans/executioner", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Executioner);
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
		this.getSprite("socket").setBrush("bust_base_nomads");
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_survival_instinct"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

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

	    	if (weapon.isAoE())
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_small_target"));
			}
	    }
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.reach_advantage");
			this.m.BaseProperties.MeleeDefense += 10;
		}

		return ret;
	}
});
