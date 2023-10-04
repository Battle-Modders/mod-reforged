::Reforged.HooksMod.hook("scripts/entity/tactical/humans/standard_bearer", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.StandardBearer);
		b.TargetAttractionMult = 1.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced by perk
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced by perk

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bolster"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_finesse"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
		}
	}
});
