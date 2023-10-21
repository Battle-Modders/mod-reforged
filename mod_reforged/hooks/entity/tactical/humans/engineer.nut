::Reforged.HooksMod.hook("scripts/entity/tactical/humans/engineer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Engineer);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/actives/load_mortar_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced as perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		}
	}
});
