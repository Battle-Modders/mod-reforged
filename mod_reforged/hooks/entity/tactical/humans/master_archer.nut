::mods_hookExactClass("entity/tactical/humans/master_archer", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MasterArcher);
		// b.DamageDirectMult = 1.25;
		// b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_marksmanship"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ballistics"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
    		{
    			this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
    		}
		}

		return ret;
	}
});
