::Reforged.HooksMod.hook("scripts/entity/tactical/humans/assassin", function(q) {
    q.onInit = @(__original) function()
    {
       this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Assassin);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect")); // Replaced with perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_double_strike"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_sneak_attack"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_tempo"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fresh_and_furious"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_ghostlike"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
		}
    }

    q.assignRandomEquipment = @(__original) function()
    {
        __original();
        ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
    }
});
