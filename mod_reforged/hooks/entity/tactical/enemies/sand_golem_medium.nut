::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/sand_golem_medium", function(q) {
	q.onInit = @() function()
	{
		this.sand_golem.onInit();
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge;
		this.getSkills().update()
	}
});
