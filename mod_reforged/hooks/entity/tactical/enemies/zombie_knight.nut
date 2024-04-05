::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_knight", function(q) {
	q.onInit = @() function()
	{
	    this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieKnight);
		// b.SurroundedBonus = 10;	// This is now controlled by them having 'Backstabber'
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		// b.FatigueDealtPerHitMult = 2.0;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

    	if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
    	}
    	else
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
    	}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			// Vanilla also adds nine_lives but we don't remove that here
			this.m.Skills.removeByID("perk.hold_out");
		}

		return ret;
	}
});
