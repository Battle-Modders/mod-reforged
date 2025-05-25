// A class that is used to save and compare state of the actor in the time between evaluation and execution of behavior.
::Reforged.AgentState <- class
{
	Agent = null;
	MoraleState = ::Const.MoraleState.Steady;
	ActionPoints = 0;
	Attributes = null;

	__IsStateSaved = false;
	__IsInvalid = false; // If true then state is considered changed even if nothing changed

	function constructor( _agent )
	{
		this.Agent = ::MSU.asWeakTableRef(_agent);
		this.Attributes = [];
	}

	function save()
	{
		::Reforged.Mod.Debug.printLog(format("AgentState.save() -- %s (%i)", this.Agent.getActor().getName(), this.Agent.getActor().getID()), "AIAgentFixes");
		local actor = this.Agent.getActor();
		this.MoraleState = actor.getMoraleState();
		this.ActionPoints = actor.getActionPoints();
		this.Attributes = this.__getAttributes();
		this.__IsStateSaved = true;
		this.__IsInvalid = false;
	}

	function clear()
	{
		::Reforged.Mod.Debug.printWarning(format("AgentState.clear() -- %s (%i)", this.Agent.getActor().getName(), this.Agent.getActor().getID()), "AIAgentFixes");
		this.__IsStateSaved = false;
		this.__IsInvalid = false;
	}

	function invalidate()
	{
		::Reforged.Mod.Debug.printWarning(format("AgentState.invalidate() -- %s (%i)", this.Agent.getActor().getName(), this.Agent.getActor().getID()), "AIAgentFixes");
		this.__IsInvalid = true;
	}

	function isInvalid()
	{
		return this.__IsInvalid;
	}

	function isStateSaved()
	{
		return this.__IsStateSaved;
	}

	function hasChanged()
	{
		if (this.__IsInvalid)
			true;

		local actor = this.Agent.getActor();
		if (actor.getMoraleState() != this.MoraleState || actor.getActionPoints() != this.ActionPoints)
		{
			return true;
		}

		foreach (i, val in this.__getAttributes())
		{
			if (val != this.Attributes[i])
			{
				return true;
			}
		}

		return false;
	}

	function __getAttributes()
	{
		local ret = array(::Const.Attributes.len() - 1);

		local actor = this.Agent.getActor();
		local p = actor.getCurrentProperties();
		foreach (attrName, attr in ::Const.Attributes)
		{
			switch (attrName)
			{
				case "Fatigue":
				case "Hitpoints":
					ret[attr] = actor["get" + attrName]();
					break;
				case "COUNT":
					continue;
				default:
					ret[attr] = p["get" + attrName]();
					break;
			}
		}
		return ret;
	}
}

// Note the hookTree because we need to overwrite this function in all the children.
::Reforged.HooksMod.hookTree("scripts/ai/tactical/behavior", function(q) {
	// Vanilla calls onBeforeExecute for the picked behavior at the end of agent.evaluate. This happens even before
	// the agent.execute runs i.e. way before the agent is actually even able to execute skills. Vanilla probably does
	// this for performance as the evaluation can run in parallel to tasks including delayed events.
	// This is problematic because the picked behavior may no longer be valid to execute after the delayed events
	// are complete. Therefore, we prevent vanilla from running this function on behaviors and instead rewrite
	// this logic in our hook on agent.execute.
	q.onBeforeExecute = @(__original) function( _entity )
	{
		if (this.getAgent().RF_canExecute())
		{
			__original(_entity);
		}
	}

	// Same comment as the function above. Vanilla does this at the end of agent.evaluate after picking a behavior.
	// We stop it here and instead rewrite this logic in our hook on agent.execute.
	q.onReset = @(__original) function()
	{
		if (this.getAgent().RF_canExecute())
		{
			__original();
		}
	}
});

::Reforged.HooksMod.hook("scripts/ai/tactical/agent", function(q) {
	q.m.RF_AgentState <- null;

	q.create = @(__original) function()
	{
		__original();
		this.m.RF_AgentState = ::Reforged.AgentState(this);
	}

	// At the beginning of a fresh evaluation i.e. when this.m.NextBehaviorToEvaluate is -3, we save the agent's state.
	// Then during agent.execute we will compare the state with this state to see if anything has changed.
	q.evaluate = @(__original) function( _entity )
	{
		::Reforged.Mod.Debug.printLog(format("evaluate -- %s (%i), NextBehaviorToEvaluate: %i", this.getActor().getName(), this.getActor().getID(), this.m.NextBehaviorToEvaluate), "AIAgentFixes");
		if (this.m.NextBehaviorToEvaluate == -3)
		{
			this.m.RF_AgentState.save();
		}
		// This should fix the crash during evaluation when entities die/move due to delayed effects
		// because such functions e.g. ai_engage_melee are generators so they yield and continue evaluation
		// but if we catch it and force a complete reset of evaluation that should avoid the crash easily.
		// Note: State becomes Invalid when any entity moves or is placed/removed on map.
		else if (this.m.RF_AgentState.isInvalid())
		{
			this.RF_reset();
			// Have to return here otherwise the __original will bump this.m.NextBehaviorToEvalute to 2
			// causing us to never save the new state again (which is done few lines above in this function).
			return;
		}
		__original(_entity);
	}

	// Prevent the AI from executing any behavior while there are delayed events scheduled.
	q.RF_canExecute <- function()
	{
		return ::Reforged.ScheduleSkills.len() == 0 && !::Time.hasEventScheduled(::TimeUnit.Virtual);
	}

	// This function is called from agent.think again and again while the executed behavior continues to return false.
	// Once it returns true, the behavior execution is considered complete and the agent can evaluate again.
	// During this situation i.e. while it is returning false, a new evaluation CANNOT start, so we don't need to
	// worry about saving state again. Instead, the first time this function is called, we compare state and then
	// clear the saved state. The state will be saved automatically again from our hook on agent.evaluate when
	// a new evaluation starts after this function returns true.
	q.execute = @(__original) function( _entity )
	{
		::Reforged.Mod.Debug.printWarning(format("execute -- %s (%i), ActiveBehavior: %s", this.getActor().getName(), this.getActor().getID(), this.m.ActiveBehavior == null ? null : this.m.ActiveBehavior.getName()), "AIAgentFixes");
		if (this.m.ActiveBehavior != null && this.m.RF_AgentState.isStateSaved())
		{
			// If state was changed then we reset and force a complete reevaluation and don't allow the behavior
			// execution to happen.
			if (this.m.RF_AgentState.hasChanged())
			{
				this.RF_reset();
				return true;
			}
			// Clear the agent state because it is not needed after the first check.
			this.m.RF_AgentState.clear();

			// This part is a copy of vanilla logic from the end of agent.evaluate which we have moved to this
			// place because otherwise it makes irreversible changes e.g. via behavior.onBeforeExecute even before
			// the behavior was executed. As we may prevent behavior execution, it is important to prevent this too.
			this.m.ActiveBehavior.onBeforeExecute(_entity);
			foreach (b in this.m.Behaviors)
			{
				b.onReset();
			}
		}
		return __original(_entity);
	}

	q.think = @(__original) function( _evaluateOnly = false )
	{
		// Prevent the AI from executing a skill while there are scheduled events
		if (!_evaluateOnly && !this.RF_canExecute())
		{
			__original(true);
			return;
		}

		__original(_evaluateOnly);
	}

	q.RF_reset <- function()
	{
		::Reforged.Mod.Debug.printWarning(format("RF_reset -- %s (%i)", this.getActor().getName(), this.getActor().getID()), "AIAgentFixes");

		// This resets the `agent.think` function to start its logic from the beginning
		this.m.NextBehaviorToEvaluate = -3;
		this.m.IsEvaluating = true;
		this.m.ActiveBehavior = null;

		// Throw away all existing generator functions of threaded behaviors
		// forcing them to start a fresh evaluation
		foreach (b in this.m.Behaviors)
		{
			b.m.Thread = null;
			b.onReset();
		}
	}
});

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// Vanilla has a bug where switchEntities callbacks don't trigger when outside player vision
	// so we trigger them manually during onMovementFinish instead.
	// We use an array because one callback may trigger another and we to support a stack of those.
	q.m.RF_switchEntitiesCallbacks <- [];

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone moved
	q.onMovementFinish = @(__original) function( _tile )
	{
		__original(_tile);

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate();
		}
		else
		{
			::logError(format("onMovementFinish activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}

		// Call the switchEntities callbacks from last to first as expected.
		while (this.m.RF_switchEntitiesCallbacks.len() != 0)
		{
			local entry = this.m.RF_switchEntitiesCallbacks.pop();
			entry[0](this, entry[1]);
		}
	}

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone moved
	q.onMovementStart = @(__original) function( _tile, _numTiles )
	{
		__original(_tile, _numTiles);

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate();
		}
		else
		{
			::logError(format("onMovementStart activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone got removed from map
	q.onRemovedFromMap = @(__original) function()
	{
		__original();

		// Some stuff may be removed from map before combat start?!e.g. if you use Breditor then the  Breditor fake bro
		// is removed before combat start and this causes an error here because TurnSequenceBar is not present yet.
		// So we need this ::Tactical.isActive() check.
		if (::Tactical.isActive())
		{
			local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
			if (activeEntity != null)
			{
				activeEntity.getAIAgent().m.RF_AgentState.invalidate();
			}
			else
			{
				::logError(format("onRemovedFromMap activeEntity null. %s (%i) ", this.getName(), this.getID()));
			}
		}
	}

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone got placed on map
	q.onPlacedOnMap = @(__original) function()
	{
		__original();

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate();
		}
		// Without this Round check, we get spammed with errors when entities are placed at combat start time
		else if (::Time.getRound() >= 1)
		{
			::logError(format("onPlacedOnMap activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}
});
