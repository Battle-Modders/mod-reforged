::mods_hookExactClass("entity/tactical/enemies/skeleton_light", function(o) {
	o.onInit = function()
	{
	    this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonLight);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
	}
});
