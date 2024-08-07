::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_knight", function(q) {
	q.onInit = @() function()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieKnight);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		// b.IsAffectedByNight = false;	// Redundant. Set via rf_zombie_racial
		// b.IsAffectedByInjuries = false;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToBleeding = true;	// Redundant. Set via rf_zombie_racial
		// b.IsImmuneToPoison = true;	// Redundant. Set via rf_zombie_racial
		// b.FatigueDealtPerHitMult = 2.0;	// Set via rf_zombie_racial

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 90)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}

	q.onSkillsUpdated = @(__original) function()
	{
		__original();
		local weapon = this.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			this.m.Skills.removeByID("actives.rf_kata_step_skill");
		}
	}
});
