// Original feature request and detailed discussion here: https://github.com/MSUTeam/MSU/issues/301

// Goal:
// - Call onActorSpawned event for all entities on the battlefield whenever an entity spawns or resurrects.
// - This call should happen AFTER the faction, skills and equipment of the entity has been assigned and equipped.

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	// This actor MUST NOT get killed during this if this spawning is via a resurrection because
	// tactical_entity_manager.onResurrect calls entity.riseFromGround after entity.onResurrected
	// and riseFromGround tries to access the entity's tile.
	q.onActorSpawned <- function( _entity )
	{
	}
});

::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onActorSpawned <- function( _entity )
	{
		this.callSkillsFunction("onActorSpawned", [
			_entity
		]);
	}
});

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// Because we call onSpawn from actor.onSkillsUpdated which happens every skill_container.update
	// we use this field to ensure that onSpawn is never called more than once for an actor.
	// Is set to false in actor.onAfterInit to allow onSpawn to trigger afterward.
	q.m.RF_HasOnSpawnBeenCalled <- true;
	// Because we trigger onSpawn from actor.onSkillsUpdated, this field is used
	// to block onSpawn from triggering during certain functions where the entity
	// is still being set up but which also triggers skill_container.update.
	// For example: during assignRandomEquipment and onResurrect.
	q.m.RF_OnSpawnBlockerCount <- 0;

	// This function should be used to do something with this entity after it has fully spawned
	// e.g. add perks based on its equipment, or something else.
	q.onSpawned <- function()
	{
	}

	// Internal function to check if it is valid to call onSpawn
	q.RF_canCallOnSpawn <- function()
	{
		// Faction is 0 when an actor is first actor.onPlacedOnMap and
		// later the faction is set correctly via actor.setFaction.
		return !this.m.RF_HasOnSpawnBeenCalled && this.m.RF_OnSpawnBlockerCount == 0 && this.isPlacedOnMap() && this.getFaction() != 0;
	}

	// Internal function to handle calling of onSpawn. We expose the public onSpawned function separately
	// so that the conditions inside this function can be handled safely by the backend as onSpawned is meant
	// to be overwritten by child classes.
	q.RF_onSpawn <- function()
	{
		if (!this.canCallOnSpawn())
			return;

		this.m.RF_HasOnSpawnBeenCalled = true;

		this.onSpawned();

		// ::logInfo(format("RF_onSpawn %s (%i) of faction %i with %i items at tile %i with %i skills and %i skillsToAdd", this.getName(), this.getID(), this.getFaction(), this.getItems().getAllItems().len(), this.getTile().ID, this.getSkills().m.Skills.len(), this.getSkills().m.SkillsToAdd.len()));

		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (actor in faction)
			{
				// This actor MUST NOT get killed during this if this spawning is via a resurrection because
				// tactical_entity_manager.onResurrect calls entity.riseFromGround after entity.onResurrected
				// and riseFromGround tries to access the entity's tile.
				actor.getSkills().onActorSpawned(this);
			}
		}
	}
});

::Reforged.QueueBucket.VeryLate.push(function() {
	::Reforged.HooksMod.hookTree("scripts/entity/tactical/actor", function(q) {
		// We call onSpawn from here because there is otherwise no real way to know
		// when an entity has finished spawning with all the skills + equipment. We keep trying
		// to call onSpawn and block it during resurrection/skills/equipment assigning manually.
		q.onSkillsUpdated = @(__original) function()
		{
			__original();
			this.RF_onSpawn();
		}

		// Prevent onSpawn from being triggered while the entity is still getting
		// its equipment assigned or skills assigned during assignRandomEquipment.
		q.assignRandomEquipment = @(__original) function()
		{
			this.m.RF_OnSpawnBlockerCount++;
			__original();
			this.m.RF_OnSpawnBlockerCount--;
		}

		// Prevent onSpawn from being triggered for the resurrecting
		// entity before it got all its skills and picked up equipment.
		q.onResurrected = @(__original) function( _info )
		{
			this.m.RF_OnSpawnBlockerCount++;
			__original(_info);
			this.m.RF_OnSpawnBlockerCount--;
			this.RF_onSpawn();
		}

		q.onAfterInit = @(__original) function()
		{
			__original();
			this.m.RF_HasOnSpawnBeenCalled = false;
		}
	});

	// Alternative approach instead of hooking actor.onResurrected
	// this will allow the actor to be safely killed inside onSpawn but
	// requires the code to be a bit uglier AND has an edge case where we can't handle
	// onSpawn calling properly if one resurrection causes another midway.

	// ::Reforged.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function(q) {
	// 	q.onResurrect = @(__original) function( _info, _force = false )
	// 	{
	// 		this.m.MSU_IsResurrecting = true;
	// 		local ret = __original(_info, _force);
	// 		if (ret != null)
	// 			ret.RF_onSpawn();
	// 		this.m.MSU_IsResurrecting = false;
	// 		return ret;
	// 	}
	// });
});
