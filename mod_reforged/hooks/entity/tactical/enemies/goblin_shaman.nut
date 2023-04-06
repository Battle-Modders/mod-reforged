::mods_hookExactClass("entity/tactical/enemies/goblin_shaman", function(o) {
	o.onInit = function()
	{
	    this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinShaman);
		b.Vision = 8;
		b.TargetAttractionMult = 2.0;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_02_head_01");
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/racial/goblin_shaman_racial"));
		// this.m.Skills.add(this.new("scripts/skills/actives/root_skill")); Added below with cooldown
		this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/grant_night_vision_skill"));

		// Reforged
		this.m.Skills.add(::MSU.new("scripts/skills/actives/root_skill", function(o) {
			o.m.Cooldown = 3;
		}));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    	}
	}
});
