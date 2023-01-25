::mods_hookExactClass("entity/tactical/enemies/sand_golem_high", function(o) {
	o.onInit = function()
	{
		this.sand_golem.onInit();
		this.grow(true);
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge + 1;
		this.getSkills().update()
	}
});
