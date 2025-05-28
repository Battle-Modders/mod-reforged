// A class that is used to save and compare state of the actor in the time between evaluation and execution of behavior.
::Reforged.AgentState <- class
{
	Agent = null;
	MoraleState = ::Const.MoraleState.Steady;
	ActionPoints = 0;
	Attributes = null;
	Properties = null;

	// Is set to `true` during execution of a behavior which is returning `false` many times.
	// Because many behaviors keep returning `false` several times and agent.execute continues to be called
	// again and again until that behavior's execution is complete.
	// We use this in agent.execute to allow the behavior to execute until the next evaluation starts.
	// Is reset back to `false` whenever agent state is saved (which is saved at evaluation start).
	__IsExecuting = false;

	// If true then state is considered changed even if nothing changed
	__IsInvalid = false;

	function constructor( _agent )
	{
		this.Agent = ::MSU.asWeakTableRef(_agent);
		this.Attributes = [];
		this.Properties = {};
	}

	function save()
	{
		::Reforged.Mod.Debug.printLog(format("AgentState.save() -- %s (%i)", this.Agent.getActor().getName(), this.Agent.getActor().getID()), "AIAgentFixes");
		local actor = this.Agent.getActor();
		this.MoraleState = actor.getMoraleState();
		this.ActionPoints = actor.getActionPoints();
		this.Attributes = this.__getAttributes();
		this.Properties = this.__getProperties();
		this.__IsExecuting = false;
		this.__IsInvalid = false;
	}

	function declareExecution()
	{
		::Reforged.Mod.Debug.printWarning(format("AgentState.declareExecution() -- %s (%i)", this.Agent.getActor().getName(), this.Agent.getActor().getID()), "AIAgentFixes");
		this.__IsExecuting = true;
	}

	function invalidate( _cause = null )
	{
		::Reforged.Mod.Debug.printWarning(format("AgentState.invalidate() -- %s (%i) - Cause: %s", this.Agent.getActor().getName(), this.Agent.getActor().getID(), _cause != null ? _cause : split(::getstackinfos(2).src, "/").top() + "." + ::getstackinfos(2).func), "AIAgentFixes");
		this.__IsInvalid = true;
	}

	function isInvalid()
	{
		return this.__IsInvalid;
	}

	function isExecuting()
	{
		return this.__IsExecuting;
	}

	function hasChanged()
	{
		if (this.__IsInvalid)
			return true;

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

		local p = actor.getCurrentProperties();
		foreach (k, v in this.__getProperties())
		{
			if (p[k] != v)
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

	function __getProperties()
	{
		local p = this.Agent.getActor().getCurrentProperties();
		return {
			IsRooted = p.IsRooted,
			IsStunned = p.IsStunned
		};
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
	q.onBeforeExecute = @(__original) { function onBeforeExecute( _entity )
	{
		if (this.getAgent().m.RF_AgentState.isExecuting())
		{
			__original(_entity);
		}
	}}.onBeforeExecute;

	// Same comment as the function above. Vanilla does this at the end of agent.evaluate after picking a behavior.
	// We stop it here and instead rewrite this logic in our hook on agent.execute.
	q.onReset = @(__original) { function onReset()
	{
		if (this.getAgent().m.RF_AgentState.isExecuting())
		{
			__original();
		}
	}}.onReset;
});

::Reforged.HooksMod.hook("scripts/ai/tactical/agent", function(q) {
	q.m.RF_AgentState <- null;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.RF_AgentState = ::Reforged.AgentState(this);
	}}.create;

	// At the beginning of a fresh evaluation i.e. when this.m.NextBehaviorToEvaluate is -3, we save the agent's state.
	// Then during agent.execute we will compare the state with this state to see if anything has changed.
	q.evaluate = @(__original) { function evaluate( _entity )
	{
		::Reforged.Mod.Debug.printLog(format("evaluate -- %s (%i), NextBehaviorToEvaluate: %i (%s)", this.getActor().getName(), this.getActor().getID(), this.m.NextBehaviorToEvaluate, this.m.NextBehaviorToEvaluate < 0 ? "" : this.m.Behaviors[this.m.NextBehaviorToEvaluate].getName()), "AIAgentFixes");
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
	}}.evaluate;

	// Prevent the AI from executing any behavior while there are delayed events scheduled.
	// hasEventScheduled covers delayed effects from `::Time.scheduleEvent`.
	// IsTravelling covers delayed effects from `teleport` and `switchEntities`.
	// During isExecuting we need to return true so that agent.think can properly call agent.execute
	// because in our hook on agent.think we convert it to only evaluate when this function is false.
	q.RF_canExecute <- { function RF_canExecute()
	{
		return this.m.RF_AgentState.isExecuting() || (!::Time.hasEventScheduled(::TimeUnit.Virtual) && !::Tactical.getNavigator().IsTravelling);
	}}.RF_canExecute;

	// This function is called from agent.think again and again while the executed behavior continues to return false.
	// Once it returns true, the behavior execution is considered complete and the agent can evaluate again.
	// During this situation i.e. while it is returning false, a new evaluation CANNOT start, so we don't need to
	// worry about saving state again. Instead, the first time this function is called, we compare state and then
	// clear the saved state. The state will be saved automatically again from our hook on agent.evaluate when
	// a new evaluation starts after this function returns true.
	q.execute = @(__original) { function execute(_entity )
	{
		::Reforged.Mod.Debug.printWarning(format("execute -- %s (%i), ActiveBehavior: %s", this.getActor().getName(), this.getActor().getID(), this.m.ActiveBehavior == null ? null : this.m.ActiveBehavior.getName()), "AIAgentFixes");
		if (this.m.ActiveBehavior != null && !this.m.RF_AgentState.isExecuting())
		{
			// If state was changed then we reset and force a complete reevaluation and don't allow the behavior
			// execution to happen.
			if (this.m.RF_AgentState.hasChanged())
			{
				this.RF_reset();
				return true;
			}
			// Tell the state that we are now in the process of executing a behavior
			// so that until this behavior is fully complete we allow calls to this function to pass through.
			this.m.RF_AgentState.declareExecution();

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
	}}.execute;

	q.think = @(__original) { function think( _evaluateOnly = false )
	{
		// Prevent the AI from executing a skill while there are scheduled events
		if (!_evaluateOnly && !this.RF_canExecute())
		{
			__original(true);
			return;
		}

		__original(_evaluateOnly);
	}}.think;

	q.RF_reset <- { function RF_reset()
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
	}}.RF_reset;
});

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	// Vanilla has a bug where switchEntities callbacks don't trigger when outside player vision
	// so we trigger them manually during onMovementFinish instead.
	// We use an array because one callback may trigger another and we to support a stack of those.
	q.m.RF_switchEntitiesCallbacks <- [];

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone moved
	q.onMovementFinish = @(__original) { function onMovementFinish( _tile )
	{
		__original(_tile);

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate(format("%s (%i).onMovementFinish", this.getName(), this.getID()));
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
	}}.onMovementFinish;

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone moved
	q.onMovementStart = @(__original) { function onMovementStart( _tile, _numTiles )
	{
		__original(_tile, _numTiles);

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate(format("%s (%i).onMovementStart", this.getName(), this.getID()));
		}
		else
		{
			::logError(format("onMovementStart activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}}.onMovementStart;

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone got removed from map
	q.onRemovedFromMap = @(__original) { function onRemovedFromMap()
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
				activeEntity.getAIAgent().m.RF_AgentState.invalidate(format("%s (%i).onRemovedFromMap", this.getName(), this.getID()));
			}
			else
			{
				::logError(format("onRemovedFromMap activeEntity null. %s (%i) ", this.getName(), this.getID()));
			}
		}
	}}.onRemovedFromMap;

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone got placed on map
	q.onPlacedOnMap = @(__original) { function onPlacedOnMap()
	{
		__original();

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_AgentState.invalidate(format("%s (%i).onPlacedOnMap", this.getName(), this.getID()));
		}
		// Without this Round check, we get spammed with errors when entities are placed at combat start time
		else if (::Time.getRound() >= 1)
		{
			::logError(format("onPlacedOnMap activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}}.onPlacedOnMap;
});

::Reforged.HooksMod.hookTree("scripts/skills/skill", function(q) {
	// Invalidate agent state whenever any Active skill is removed from him.
	// This covers all cases where a delayed effect may cause the skill which had been chosen
	// by a behavior to now be removed from the actor.
	// Examples: Weapon breaking after an attack. The breakage is a delayed event in vanilla.
	q.onRemoved = @(__original) { function onRemoved()
	{
		__original();
		if (this.isActive())
		{
			this.getContainer().getActor().getAIAgent().m.RF_AgentState.invalidate(this.ClassName + ".onRemoved");
		}
	}}.onRemoved;
});
