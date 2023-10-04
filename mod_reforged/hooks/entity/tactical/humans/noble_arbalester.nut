::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_arbalester", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Arbalester);
		b.TargetAttractionMult = 1.1;
		// b.IsSpecializedInCrossbows = true; // Replaced with perk
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_entrenched"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));

		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_iron_sights"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
    	}
	}
});
