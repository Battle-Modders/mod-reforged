// Vanilla does not retain the Cost entry in the troop
// in world entities after deserialization. We need this information
// in getTooltip of world entities to display dev related info.
::Reforged.QueueBucket.AfterHooks.push(function() {
	local map = {};
	foreach (t in ::Const.World.Spawn.Troops)
	{
		map[t.Script] <- t;
	}
	::Const.World.Spawn.RF_ScriptToTroopMap <- map;
});
