// Spawned from the craftable_schrat_shield
this.rf_schrat_small_from_shield <- ::inherit("scripts/entity/tactical/enemies/schrat_small", {
	m = {},
	function create()
	{
		this.schrat_small.create();
	}

	function onInit()
	{
		this.schrat_small.onInit();
		this.m.IsActingImmediately = true;
	}
});
