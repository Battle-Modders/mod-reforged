::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghoul_high", function(q) {
	q.onInit = @() function()
	{
		this.ghoul.onInit();
		this.grow(true);
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge + 1;
		this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
	}
});
