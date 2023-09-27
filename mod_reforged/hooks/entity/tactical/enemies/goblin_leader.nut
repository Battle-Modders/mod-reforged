::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_leader", function(q) {
	q.onInit = @(__original) function()
	{
	    this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinLeader);
		b.TargetAttractionMult = 1.5;
		// b.DamageDirectMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInCrossbows = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/actives/goblin_whip"));

		// Reforged
		::Reforged.Skills.addPerkGroup(this, "pg.rf_sword");
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_muscle_memory"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
    	}
	}
});
