::Reforged.HooksMod.hook("scripts/scenarios/world/anatomists_scenario", function(q) {
	q.onSpawnAssets = @(__original) { function onSpawnAssets()
	{
		__original();
		// Same as vanilla but instead of hard-coded flags, we iterate over our global table
		foreach (info in ::Reforged.Items.AnatomistPotions.Infos)
		{
			::World.Statistics.getFlags().set(info.AcquiredFlagName, false);
		}
	}}.onSpawnAssets;

	q.onBattleWon = @(__original) { function onBattleWon( _combatLoot )
	{
		__original(_combatLoot);
		// Same as vanilla but instead of hard-coded flags, we iterate over our global table
		foreach (info in ::Reforged.Items.AnatomistPotions.Infos)
		{
			if (!::World.Statistics.getFlags().get(info.AcquiredFlagName) && ::World.Statistics.getFlags().get(info.ShouldDropFlagName))
			{
				::World.Statistics.getFlags().set(info.AcquiredFlagName, true);
				::World.Statistics.getFlags().set(info.DiscoveredFlagName, true);
				_combatLoot.add(::new(info.ItemScript));
			}
		}
	}}.onBattleWon;

	// Same as vanilla but instead of hard-coded flags, we check in our global table
	q.onActorKilled = @(__original) { function onActorKilled( _actor, _killer, _combatID )
	{
		__original(_actor, _killer, _combatID);

		if (::Tactical.State.getStrategicProperties().IsArenaMode)
		{
			return;
		}

		if (_killer != null && _killer.getFaction() != ::Const.Faction.Player && _killer.getFaction() != ::Const.Faction.PlayerAnimals)
		{
			return;
		}

		if (_actor.getType() in ::Reforged.Items.AnatomistPotions.Infos)
		{
			::World.Statistics.getFlags().set(::Reforged.Items.AnatomistPotions.getInfo(_actor.getType()).ShouldDropFlagName, true);
		}
	}}.onActorKilled;

	// Same as vanilla but instead of hard-coded flags, we iterate over our global table
	q.onCombatFinished = @(__original) { function onCombatFinished()
	{
		local ret = __original();
		foreach (info in ::Reforged.Items.AnatomistPotions.Infos)
		{
			::World.Statistics.getFlags().set(info.ShouldDropFlagName, false);
		}
		return ret;
	}}.onCombatFinished;
});
