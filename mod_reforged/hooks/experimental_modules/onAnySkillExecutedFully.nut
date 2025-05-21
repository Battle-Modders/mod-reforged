// This is a testing module for MSU to add a new skill event `onAnySkillExecutedFully` which is triggered
// after all the delayed effects inside a skill execution e.g. scheduleEvent, teleport, switchEntities are complete.

// Keys in this table are skill instances which are being used via `skill.use`.
// Values are instances of ScheduleSkill.
// During skill.use an instance of ScheduleSkill is created and a key/value pair is stored here.
::Reforged.ScheduleSkills <- {};

// This class handles keeping track of how many delayed events (e.g. scheduleEvent, teleport) have been
// queued for a skill and how many have been completed. Once all are completed this class triggers
// the onAnySkillExecutedFully event for the container this skill belonged to and then deletes the key from ScheduledSkills.
// Note: It holds a strong reference to the skill, so the skill can never become null while this is keeping track of it.
::Reforged.ScheduleSkill <- class {
	Skill = null;
	Container = null;
	TargetTile = null;
	TargetEntity = null;
	ForFree = false;

	Count = 0;

	constructor( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.Skill = _skill;
		this.Container = _skill.getContainer();
		this.TargetTile = _targetTile;
		this.TargetEntity = _targetEntity;
		this.ForFree = _forFree;
	}

	function onScheduleComplete()
	{
		// Check for <= 0 because when we call this manually, this.Count will be 0 and will drop to -1
		if (--this.Count <= 0)
		{
			if (!::MSU.isNull(this.Container))
				this.Container.onAnySkillExecutedFully(this.Skill, this.TargetTile, this.TargetEntity, this.ForFree);
			delete ::Reforged.ScheduleSkills[this.Skill];
		}
	}
};

// Looks through the stackinfos and returns the skill which called a scheduling function e.g. ::Time.scheduleEvent.
// This only includes skills which are present in ::Reforged.ScheduleSkills and that means only skills that are being used.
// Returns null if the function was called by anything else.
local function getSchedulerSkill()
{
	// 0 = "getstackinfos"; 1 = "getSchedulerSkill"; 2 = scheduler function e.g. ::Time.scheduleEvent which wants to know the skill that called it
	local level = 3;
	local infos = ::getstackinfos(level);

	// frameUpdate is an MSU keybinds system function which calls ::Time.scheduleEvent on every frame
	if (infos.func == "frameUpdate")
		return null;

	do
	{
		// We skip native functions, this includes calls from .call or .acall etc.
		if (infos.src == "NATIVE")
		{
			infos = ::getstackinfos(++level);
			continue;
		}

		local caller = infos.locals["this"];
		return caller in ::Reforged.ScheduleSkills ? caller : null;
	}
	while(infos != null);

	return null;
}

// Returns a wrapped callback function for schedule functions e.g. ::Time.scheduleEvent. The callback
// is wrapped to trigger the onScheduleComplete() function for the schedule.
// Also increments the schedule Count of the relevant skill.
// Note: _countBump is necessary as a param because ::Tactical.switchEntities needs to increase
// count by 2 on every call as its callback is triggered twice: once for each entity being switched.
local function getWrapper( _caller, _func, _numArgs, _countBump = 1 )
{
	local schedule = ::Reforged.ScheduleSkills[_caller];
	schedule.Count += _countBump;

	if (_numArgs == 1)
	{
		return function( _arg1 )
		{
			if (_func != null)
				_func(_arg1);
			schedule.onScheduleComplete();
		}
	}
	else
	{
		return function( _arg1, _arg2 )
		{
			if (_func != null)
				_func(_arg1, _arg2);
			schedule.onScheduleComplete();
		}
	}
}

// We overwrite the three functions `scheduleEvent`, `teleport` and `switchEntities` to add a custom callback function
// that triggers the onScheduleComplete event inside ScheduledSkill class.

local scheduleEvent = ::Time.scheduleEvent;
::Time.scheduleEvent = function( _timeUnit, _time, _func, _data )
{
	if (_timeUnit == ::TimeUnit.Rounds)
	{
		scheduleEvent(_timeUnit, _time, _func, _data);
		return;
	}

	local caller = getSchedulerSkill();
	if (caller == null)
	{
		scheduleEvent(_timeUnit, _time, _func, _data);
		return;
	}

	scheduleEvent(_timeUnit, _time, getWrapper(caller, _func, 1), _data);
}

local teleport = ::TacticalNavigator.teleport;
::TacticalNavigator.teleport <- function( _user, _targetTile, _func, _data, _bool, _float = 1.0 )
{
	local caller = getSchedulerSkill();
	if (caller == null)
	{
		teleport(_user, _targetTile, _func, _data, _bool, _float);
		return;
	}

	teleport(_user, _targetTile, getWrapper(caller, _func, 2), _data, _bool, _float);
}

local switchEntities = ::TacticalNavigator.switchEntities;
::TacticalNavigator.switchEntities <- function( _user, _targetEntity, _func, _data, _float )
{
	local caller = getSchedulerSkill();
	if (caller == null)
	{
		switchEntities(_user, _targetEntity, _func, _data, _float);
		return;
	}

	// Increase count by 2 because the callback is called for both entities
	switchEntities(_user, _targetEntity, getWrapper(caller, _func, 2, 2), _data, _float);
}

::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onAnySkillExecutedFully <- function( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Don't update if using a skill that sets Tile to ID 0 e.g. Rotation because this leads
		// to crashes if any skill tries to access the current tile in its onUpdate
		// function as the tile at this point is not a valid tile.

		this.callSkillsFunction("onAnySkillExecutedFully", [
			_skill,
			_targetTile,
			_targetEntity,
			_forFree
		], this.getActor().isPlacedOnMap());
	}
});

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.onAnySkillExecutedFully <- function( _skill, _targetTile, _targetEntity, _forFree )
	{
	}

	q.use = @(__original) function( _targetTile, _forFree = false )
	{
		local scheduleSkill = ::Reforged.ScheduleSkill(this, _targetTile, _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null, _forFree);
		::Reforged.ScheduleSkills[this] <- scheduleSkill;

		// The original MSU events of onBeforeAnySkillExecuted and onAnySkilLExecuted will trigger here`
		local ret = __original(_targetTile, _forFree);

		// If no delayed event was scheduled we trigger the onAnySkillExecutedFully manually
		if (scheduleSkill.Count == 0)
		{
			scheduleSkill.onScheduleComplete();
		}

		return ret;
	}
});

::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	q.executeEntitySkill = @(__original) function( _activeEntity, _targetTile )
	{
		// Prevent executing a skill while the previously executed skill has not fully finished executing
		// including all its delayed effects
		if (::Reforged.ScheduleSkills.len() != 0)
		{
			::Tactical.EventLog.log(::MSU.Text.colorNegative("Already executing a skill!"));
			return;
		}

		__original(_activeEntity, _targetTile);
	}
});

// A class that is used to save and compare state of the actor in the time between evaluation and execution of behavior.
::Reforged.AgentState <- class
{
	Agent = null;
	MoraleState = ::Const.MoraleState.Steady;
	ActionPoints = 0;
	Attributes = null;

	__IsStateSaved = false;

	function constructor( _agent )
	{
		this.Agent = ::MSU.asWeakTableRef(_agent);
		this.Attributes = [];
	}

	function save()
	{
		local actor = this.Agent.getActor();
		this.MoraleState = actor.getMoraleState();
		this.ActionPoints = actor.getActionPoints();
		this.Attributes = this.__getAttributes();
		this.__IsStateSaved = true;
	}

	function clear()
	{
		this.__IsStateSaved = false;
	}

	function isStateSaved()
	{
		return this.__IsStateSaved;
	}

	function hasChanged()
	{
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
	// the agent.execute runs i.e. way before the agent is actually even able to execute skills. Vailla probably does
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
	// The following is set to true whenever any actor dies or moves. Then we tell the agent to reevaluate.
	q.m.RF_ForceReevaluate <- false;

	q.create = @(__original) function()
	{
		__original();
		this.m.RF_AgentState = ::Reforged.AgentState(this);
	}

	// At the beginning of a fresh evaluation i.e. when this.m.NextBehaviorToEvaluate is -3, we save the agent's state.
	// Then during agent.execute we will compare the state with this state to see if anything has changed.
	q.evaluate = @(__original) function( _entity )
	{
		if (this.m.NextBehaviorToEvaluate == -3)
		{
			this.m.RF_ForceReevaluate = false;
			this.m.RF_AgentState.save();
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
		if (this.m.ActiveBehavior != null && this.m.RF_AgentState.isStateSaved())
		{
			// If state was changed then we reset and force a complete reevaluation and don't allow the behavior
			// execution to happen.
			if (this.m.RF_ForceReevaluate || this.m.RF_AgentState.hasChanged())
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
		this.m.RF_ForceReevaluate = false;

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
			activeEntity.getAIAgent().m.RF_ForceReevaluate = true;
		}
		else
		{
			::logError(format("onMovementFinish activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}

	// Force the currently active entity to throw away his picked behavior and reevalute if anyone moved
	q.onMovementStart = @(__original) function( _tile, _numTiles )
	{
		__original(_tile, _numTiles);

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (activeEntity != null)
		{
			activeEntity.getAIAgent().m.RF_ForceReevaluate = true;
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
				activeEntity.getAIAgent().m.RF_ForceReevaluate = true;
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
			activeEntity.getAIAgent().m.RF_ForceReevaluate = true;
		}
		// Without this Round check, we get spammed with errors when entities are placed at combat start time
		else if (::Time.getRound() >= 1)
		{
			// This spams errors at combat start because Active
			::logError(format("onPlacedOnMap activeEntity null. %s (%i) ", this.getName(), this.getID()));
		}
	}
});
