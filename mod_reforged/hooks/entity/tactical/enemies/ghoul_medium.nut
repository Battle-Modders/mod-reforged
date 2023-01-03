::mods_hookExactClass("entity/tactical/enemies/ghoul_medium", function(o) {
	o.onInit = function()
	{
		this.ghoul.onInit();
		this.grow(true);

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}
});
