::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_boss", function(q) {
	q.onInit = @(__original) function()
	{
	    this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonBoss);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		b.IsImmuneToDisarm = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));

		// Reforged
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_personal_armor"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_sergeant"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_man_of_steel"));
		}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}
});
