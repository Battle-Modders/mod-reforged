::mods_hookExactClass("entity/tactical/enemies/sand_golem_medium", function(o) {
	o.onInit = function()
	{
		this.sand_golem.onInit();
		this.grow(true);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium +1;
	}

});
