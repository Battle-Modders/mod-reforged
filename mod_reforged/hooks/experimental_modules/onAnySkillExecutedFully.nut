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
	WasScheduled = false;

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
		if (this.WasScheduled)
			::Reforged.Mod.Debug.printLog(format("onScheduleComplete -- ID: %s, Count: %i", this.Skill.getID(), this.Count), "onAnySkillExecutedFully");
		else
			::Reforged.Mod.Debug.printLog(format("onScheduleComplete -- ID: %s, Count: %i -- Nothing was scheduled (normal skill)", this.Skill.getID(), this.Count), "onAnySkillExecutedFully");
		// Check for <= 0 because when we call this manually, this.Count will be 0 and will drop to -1
		if (--this.Count <= 0)
		{
			if (this.WasScheduled)
				::Reforged.Mod.Debug.printLog(format("onScheduleComplete -- ID: %s, Count: %i - Schedule Complete", this.Skill.getID(), this.Count), "onAnySkillExecutedFully");
			else
				::Reforged.Mod.Debug.printLog(format("onScheduleComplete -- ID: %s, Count: %i - Schedule Complete -- Nothing was scheduled (normal skill)", this.Skill.getID(), this.Count), "onAnySkillExecutedFully");

			if (!::MSU.isNull(this.Container))
				this.Container.onAnySkillExecutedFully(this.Skill, this.TargetTile, this.TargetEntity, this.ForFree);
			delete ::Reforged.ScheduleSkills[this.Skill];
		}
	}

	function addCount( _num = 1 )
	{
		this.Count += _num;
		this.WasScheduled = true;
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
	schedule.addCount(_countBump);

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

	::Reforged.Mod.Debug.printLog(format("scheduleEvent -- ID: %s, Count: %i", caller.getID(), ::Reforged.ScheduleSkills[caller].Count + 1), "onAnySkillExecutedFully");

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

	::Reforged.Mod.Debug.printLog(format("teleport -- ID: %s, Count: %i", caller.getID(), ::Reforged.ScheduleSkills[caller].Count + 1), "onAnySkillExecutedFully");

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

	::Reforged.Mod.Debug.printLog(format("switchEntities -- ID: %s, Count: %i", caller.getID(), ::Reforged.ScheduleSkills[caller].Count + 2), "onAnySkillExecutedFully");

	// Increase count by 2 because the callback is called for both entities
	local cbEntry = [getWrapper(caller, _func, 2, 2), _data];

	// Vanilla has a bug where switchEntities callbacks don't trigger when outside player vision
	// so we trigger them manually during actor.onMovementFinish instead and set the native callback to null
	_user.m.RF_switchEntitiesCallbacks.push(cbEntry);
	_targetEntity.m.RF_switchEntitiesCallbacks.push(cbEntry);

	switchEntities(_user, _targetEntity, null, null, _float);
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
		// Note: We can't just check for .Count == 0 because in fog of war teleport/switchEntities
		// happens immediately without delay, so Count will be 0 here even if those happened and the
		// event would have already been properly handled leading to errors when calling it manually again.
		if (!scheduleSkill.WasScheduled)
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
