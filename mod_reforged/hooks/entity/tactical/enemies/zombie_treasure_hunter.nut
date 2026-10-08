::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_treasure_hunter", function(q) {
	q.onInit = @(__original) function()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieTreasureHunter);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		// b.IsAffectedByNight = false;	// Redundant. Set via rf_zombie_racial
		// b.IsAffectedByInjuries = false;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToBleeding = true;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToPoison = true;	// Redundant. Set via rf_zombie_racial
		// b.FatigueDealtPerHitMult = 2.0;	// Set via rf_zombie_racial
		b.DamageTotalMult = 1.25;
		b.DamageReceivedArmorMult = 0.75;
		this.m.Skills.update();
	}
});
