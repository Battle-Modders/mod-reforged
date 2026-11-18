::Reforged.HooksMod.hook("scripts/states/world/asset_manager", function(q) {
	q.resetToDefaults = @(__original) { function resetToDefaults()
	{
		__original();

		// Implement effect while pursuing and after finishing "A worthy Foe" ambition
		local worthyFoeAmbition = ::World.Ambitions.getAmbition("ambition.rf_a_worthy_foe");
		if (worthyFoeAmbition.isDone())
		{
			this.m.ChampionChanceAdditional += worthyFoeAmbition.m.ChampionChanceReward;
		}
		else if (::MSU.isEqual(worthyFoeAmbition, ::World.Ambitions.getActiveAmbition()))
		{
			this.m.ChampionChanceAdditional += worthyFoeAmbition.m.ChampionChancePassive;
		}
	}}.resetToDefaults;
});
