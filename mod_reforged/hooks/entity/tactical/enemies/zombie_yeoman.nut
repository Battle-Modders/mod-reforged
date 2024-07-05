::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_yeoman", function(q) {
	q.onInit = @() function()
	{
	    this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieYeoman);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		// b.IsAffectedByNight = false;	// Redundant. Set via rf_zombie_racial
		// b.IsAffectedByInjuries = false;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToBleeding = true;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToPoison = true;	// Redundant. Set via rf_zombie_racial

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		// {
		// 	b.FatigueDealtPerHitMult = 2.0;	// Set via rf_zombie_racial
		// }

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		// {
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();

		// Reforged
	}
});
