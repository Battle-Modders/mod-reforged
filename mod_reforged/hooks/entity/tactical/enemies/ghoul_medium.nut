::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghoul_medium", function(q) {
	q.onInit = @() function()
	{
		this.ghoul.onInit();
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium + 1;
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
	}
});
