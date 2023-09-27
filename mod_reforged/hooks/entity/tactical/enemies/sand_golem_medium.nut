::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/sand_golem_medium", function(q) {
	q.onInit = @(__original) function()
	{
		this.sand_golem.onInit();
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium + 1;
		this.getSkills().update()
	}

});
