::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghoul_medium", function(q) {
	q.onInit = @() function()
	{
		this.ghoul.onInit();
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium + 1;
		this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));
	}
});
