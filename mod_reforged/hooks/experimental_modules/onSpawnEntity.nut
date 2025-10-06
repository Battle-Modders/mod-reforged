// Original feature request and detailed discussion here: https://github.com/MSUTeam/MSU/issues/301

// Goal:
// - Call onActorSpawned event for all entities on the battlefield whenever an entity spawns or resurrects.
// - This call should happen AFTER the faction, skills and equipment of the entity has been assigned and equipped.

local spawnEntity = ::Tactical.spawnEntity;
::Tactical.spawnEntity = function( ... )
{
	vargv.insert(0, this);
	local e = spawnEntity.acall(vargv);

	// We schedule the RF_onSpawn function to be called in the next frame
	// so that all linear logic following this entity's spawning e.g.
	// equipping of items or adding of skills happens before the callback.
	::Time.scheduleEvent(::TimeUnit.Virtual, 1, e.RF_onSpawn.bindenv(e), null);
	return e;
}

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

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// This function should be used to do something with this entity after it has fully spawned
	// e.g. add perks based on its equipment, or something else.
	q.onSpawned <- { function onSpawned()
	{
	}}.onSpawned;

	// Internal function to handle calling of onSpawn. We expose the public onSpawned function separately
	// so that the conditions inside this function can be handled safely by the backend as onSpawned is meant
	// to be overwritten by child classes.
	// The single parameter is necessary as this function is used in Time.scheduleEvent
	q.RF_onSpawn <- { function RF_onSpawn( _ )
	{
		this.onSpawned();

		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (actor in faction)
			{
				actor.getSkills().onActorSpawned(this);
			}
		}
	}}.RF_onSpawn;
});
