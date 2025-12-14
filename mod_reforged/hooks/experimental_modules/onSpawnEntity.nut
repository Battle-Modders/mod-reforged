// Original feature request and detailed discussion here: https://github.com/MSUTeam/MSU/issues/301

// Goal:
// - Call onActorSpawned event for all entities on the battlefield whenever an entity spawns or resurrects.
// - This call should happen AFTER the faction, skills and equipment of the entity has been assigned and equipped.

local spawnEntity = ::Tactical.spawnEntity;
::Tactical.spawnEntity = { function spawnEntity( ... )
{
	vargv.insert(0, this);
	local e = spawnEntity.acall(vargv);
	if (::isKindOf(e, "actor"))
	{
		// We schedule the RF_onSpawn function to be called in the next frame
		// so that all linear logic following this entity's spawning e.g.
		// equipping of items or adding of skills happens before the callback.
		::Time.scheduleEvent(::TimeUnit.Virtual, 1, ::Tactical.Entities.RF_onSpawn, e);
	}
	return e;
}}.spawnEntity;

local addEntityToMap = ::Tactical.addEntityToMap;
::Tactical.addEntityToMap = { function addEntityToMap( _entity, _x, _y )
{
	addEntityToMap(_entity, _x, _y);
	if (::isKindOf(_entity, "actor"))
	{
		// We schedule the RF_onSpawn function to be called in the next frame
		// so that all linear logic following this entity's spawning e.g.
		// equipping of items or adding of skills happens before the callback.
		::Time.scheduleEvent(::TimeUnit.Virtual, 1, ::Tactical.Entities.RF_onSpawn, _entity);
	}
}}.addEntityToMap;

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.onActorSpawned <- { function onActorSpawned( _entity )
	{
	}}.onActorSpawned;
});

::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onActorSpawned <- { function onActorSpawned( _entity )
	{
		this.callSkillsFunction("onActorSpawned", [
			_entity
		]);
	}}.onActorSpawned;
});

::Reforged.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function(q) {
	// Internal function to handle calling of of actor.onSpawned.
	// Similar to how `onResurrect` in this class in vanilla calls` actor.onResurrected`.
	q.RF_onSpawn <- { function RF_onSpawn( _actor )
	{
		if (!_actor.getFlags().has("RF_HasOnSpawnBeenCalled"))
			return;

		_actor.getFlags().set("RF_HasOnSpawnBeenCalled", true);

		_actor.onSpawned();

		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (actor in faction)
			{
				actor.getSkills().onActorSpawned(_actor);
			}
		}
	}}.RF_onSpawn;
});

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// This function should be used to do something with this entity after it has fully spawned
	// e.g. add perks based on its equipment, or something else.
	q.onSpawned <- { function onSpawned()
	{
	}}.onSpawned;
});

::Reforged.QueueBucket.VeryLate.push(function() {
	::Reforged.HooksMod.hook("scripts/entity/tactical/player", function(q) {
		q.onCombatFinished = @(__original) { function onCombatFinished()
		{
			// Remove the flag before calling __original so any exception during __original
			// doesn't prevent the flag from being removed.
			this.getFlags().remove("RF_HasOnSpawnBeenCalled");
			__original();
		}}.onCombatFinished;
	});
});
