::mods_hookExactClass("entity/tactical/enemies/skeleton_medium", function(o) {
	o.onInit = function()
	{
	    this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonMedium);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
	}
});
