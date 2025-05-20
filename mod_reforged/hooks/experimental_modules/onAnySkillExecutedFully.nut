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
	Agent = null;

	Count = 0;

	// State of the actor as it was when the first delayed event was scheduled during a skill use
	// Is used to tell the agent to restart its evaluation if something important changed on the battlefield
	// which may make the results of previously evaluated behaviors potentially invalid.
	APBefore = 0;
	MoraleStateBefore = ::Const.MoraleState.Steady;
	// The following is set to true when any actor dies or moves while a delayed event is scheduled.
	// Is set from hooks on actor.onDeath and actor.onMovementFinish
	ForceReevaluate = false;

	constructor( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.Skill = _skill;
		this.Container = _skill.getContainer();
		this.TargetTile = _targetTile;
		this.TargetEntity = _targetEntity;
		this.ForFree = _forFree;
		this.Agent = this.Container.getActor().getAIAgent();
	}

	function onScheduleComplete()
	{
		// Check for <= 0 because when we call this manually, this.Count will be 0 and will drop to -1
		if (--this.Count <= 0)
		{
			if (!::MSU.isNull(this.Container))
				this.Container.onAnySkillExecutedFully(this.Skill, this.TargetTile, this.TargetEntity, this.ForFree);
			// this.Count == 0 check because if count is -1 that means no delayed event was scheduled.
			if (this.Count == 0 && this.didStateChange())
				this.Agent.m.RF_ForceReevaluate = true;
			delete ::Reforged.ScheduleSkills[this.Skill];
		}
	}

	function saveStartingState()
	{
		local actor = this.Container.getActor();
		this.APBefore = actor.getActionPoints();
		this.MoraleStateBefore = actor.getMoraleState();
	}

	function didStateChange()
	{
		local actor = this.Container.getActor();
		if (::MSU.isNull(actor) || !actor.isAlive())
			return true;

		return this.ForceReevaluate || actor.getMoraleState() != this.MoraleStateBefore || actor.getActionPoints() != this.APBefore;
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
// Also increments the schedule Count of the relevant skill and saves the actor state when at Count 0.
// Note: _countBump is necessary as a param because ::Tactical.switchEntities needs to increase count by 2 on every call
// as its callback is triggered twice: once for each entity being switched.
local function getWrapper( _caller, _func, _numArgs, _countBump = 1 )
{
	local schedule = ::Reforged.ScheduleSkills[_caller];
	if (schedule.Count == 0)
	{
		schedule.saveStartingState();
	}
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

::Reforged.HooksMod.hook("scripts/ai/tactical/agent", function(q) {
	q.m.RF_ForceReevaluate <- false;
	// Prevent the AI from executing a skill while the previously executed skill has not fully finished executing
	// including all its delayed effects
	q.think = @(__original) function( _evaluateOnly = false )
	{
		if (::Reforged.ScheduleSkills.len() != 0)
		{
			__original(true);
			return;
		}

		if (this.m.RF_ForceReevaluate)
		{
			this.m.RF_ForceReevaluate = false;

			// This resets the `agent.think` function to start its logic from the beginning
			this.m.NextBehaviorToEvaluate = -3;

			// Throw away all existing generator functions of threaded behaviors
			// forcing them to start a fresh evaluation
			foreach (b in this.m.Behaviors)
			{
				b.m.Thread = null;
			}
		}

		__original(_evaluateOnly);
	}
});

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		foreach (s in ::Reforged.ScheduleSkills)
		{
			s.ForceReevaluate = true;
		}
		__original(_killer, _skill, _tile, _fatalityType);
	}

	q.onMovementFinish = @(__original) function( _tile )
	{
		foreach (s in ::Reforged.ScheduleSkills)
		{
			s.ForceReevaluate = true;
		}
		__original(_tile);
	}
});
