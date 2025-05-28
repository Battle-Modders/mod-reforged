::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/sand_golem_high", function(q) {
	q.onInit = @() { function onInit()
	{
		this.sand_golem.onInit();
		this.grow(true);
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastHuge + 1;
		this.getSkills().update()
	}}.onInit;
});
