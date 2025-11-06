// This is a testing module for MSU to add a new skill event `onAnySkillExecutedFully` which is triggered
// after all the delayed effects inside a skill execution e.g. scheduleEvent, teleport, switchEntities are complete.

// This class handles keeping track of how many delayed events (e.g. scheduleEvent, teleport) have been
// queued for a skill and how many have been completed. Once all are completed this class triggers
// the onAnySkillExecutedFully event for the container this skill belonged to and then deletes the key from ScheduledSkills.
// Note: It holds a strong reference to the skill, so the skill can never become null while this is keeping track of it.
::Reforged.SkillSchedule <- class {
	Container = null;
	TargetTile = null;
	TargetEntity = null;
	ForFree = false;

	Count = 0;
	WasScheduled = false;

	constructor( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.Container = ::MSU.asWeakTableRef(_skill.getContainer());
		this.TargetTile = _targetTile;
		this.TargetEntity = _targetEntity;
		this.ForFree = _forFree;
	}

	function onScheduleComplete( _info )
	{
		if (this.WasScheduled)
			::Reforged.Mod.Debug.printLog(format("Caller: %s.%s (%s : %i), Callback: %s, Count: %i", _info.Skill.ClassName, _info.Func, _info.Src, _info.Line, _info.Callback, this.Count), "onAnySkillExecutedFully");
		else
			::Reforged.Mod.Debug.printLog(format("Caller: %s, Count: %i -- Nothing was scheduled (normal skill)", _info.Skill.ClassName, this.Count), "onAnySkillExecutedFully");
		// Check for <= 0 because when we call this manually, this.Count will be 0 and will drop to -1
		if (--this.Count <= 0)
		{
			if (this.WasScheduled)
				::Reforged.Mod.Debug.printLog(format("Schedule Complete -- Caller: %s.%s (%s : %i), Callback: %s, Count: %i", _info.Skill.ClassName, _info.Func, _info.Src, _info.Line, _info.Callback, this.Count), "onAnySkillExecutedFully");
			else
				::Reforged.Mod.Debug.printLog(format("Schedule Complete -- ClassName: %s, Count: %i -- Nothing was scheduled (normal skill)", _info.Skill.ClassName, this.Count), "onAnySkillExecutedFully");

			if (!::MSU.isNull(this.Container))
				this.Container.onAnySkillExecutedFully(_info.Skill, this.TargetTile, this.TargetEntity, this.ForFree);
			_info.Skill.m.RF_Schedule = null;
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
local function getSchedulerInfo()
{
	// 0 = "getstackinfos"; 1 = "getSchedulerInfo"; 2 = scheduler function e.g. ::Time.scheduleEvent which wants to know the skill that called it
	local level = 3;
	local infos = ::getstackinfos(level);

	do
	{
		// We skip native functions, this includes calls from .call or .acall etc.
		if (infos.src == "NATIVE")
		{
			infos = ::getstackinfos(++level);
			continue;
		}

		local caller = infos.locals["this"];
		// if (::isKindOf(caller, "skill") && caller.m.RF_Schedule != null)
		// {
			// Technically we only need to return `caller` but we return the function name as well for debug logging
			return {
				Skill = caller,
				Func = infos.func,
				Src = infos.src,
				Line = infos.line
			};
		// }

		return null;
	}
	while(infos != null);

	return null;
}

// Returns a wrapped callback function for schedule functions e.g. ::Time.scheduleEvent. The callback
// is wrapped to trigger the onScheduleComplete() function for the schedule.
// Also increments the schedule Count of the relevant skill.
// Note: _countBump is necessary as a param because ::Tactical.switchEntities needs to increase
// count by 2 on every call as its callback is triggered twice: once for each entity being switched.
local function getWrapper( _info, _func, _numArgs, _type = "scheduleEvent", _countBump = 1 )
{
	local schedule = _info.Skill.m.RF_Schedule;
	schedule.addCount(_countBump);

	if (_numArgs == 1)
	{
		return function( _arg1 )
		{
			::Reforged.Mod.Debug.printLog(format("Triggering %s Callback - Caller: %s.%s (%s : %i), Callback: %s", _type, "ClassName" in _info.Skill ? _info.Skill.ClassName : split(_info.Src, "/").top(), _info.Func, _info.Src, _info.Line, _info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg1);
			}
			schedule.onScheduleComplete(_info);
		}
	}
	else
	{
		return function( _arg1, _arg2 )
		{
			::Reforged.Mod.Debug.printLog(format("Triggering %s Callback - Caller: %s.%s (%s : %i), Callback: %s", _type, "ClassName" in _info.Skill ? _info.Skill.ClassName : split(_info.Src, "/").top(), _info.Func, _info.Src, _info.Line, _info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg1, _arg2);
			}
			schedule.onScheduleComplete(_info);
		}
	}
}

// We overwrite the three functions `scheduleEvent`, `teleport` and `switchEntities` to add a custom callback function
// that triggers the onScheduleComplete event inside ScheduledSkill class.

local scheduleEvent = ::Time.scheduleEvent;
::Time.scheduleEvent = { function scheduleEvent( _timeUnit, _time, _func, _data )
{
	if (_timeUnit != ::TimeUnit.Virtual)
	{
		scheduleEvent(_timeUnit, _time, _func, _data);
		return;
	}

	local info = getSchedulerInfo();
	if (info == null)
	{
		scheduleEvent(_timeUnit, _time, _func, _data);
		return;
	}

	// This is just put in there for debug printing
	info.Callback <- _func == null ? "null" : (_func.getinfos().name == null ? "unknown" : _func.getinfos().name);

	if (!::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null)
	{
		::Reforged.Mod.Debug.printLog(format("OTHER -- Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		local function wrapper( _arg )
		{
			::Reforged.Mod.Debug.printLog(format("OTHER -- Triggering scheduleEvent Callback - Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg);
			}
		}
		scheduleEvent(_timeUnit, _time, wrapper, _data);
		return;
	}

	::Reforged.Mod.Debug.printLog(format("Caller: %s.%s (%s : %i), Callback: %s, Count: %i", info.Skill.ClassName, info.Func, info.Src, info.Line, info.Callback, info.Skill.m.RF_Schedule.Count + 1), "onAnySkillExecutedFully");

	scheduleEvent(_timeUnit, _time, getWrapper(info, _func, 1), _data);
}}.scheduleEvent;

local teleport_6 = ::TacticalNavigator["__sqrat_ol_ teleport_6"];
::TacticalNavigator["__sqrat_ol_ teleport_6"] <- { function teleport( _user, _targetTile, _func, _data, _bool, _float )
{
	local info = getSchedulerInfo();
	if (info == null)
	{
		teleport_6(_user, _targetTile, _func, _data, _bool, _float);
		return;
	}

	// This is just put in there for debug printing
	info.Callback <- _func == null ? "null" : (_func.getinfos().name == null ? "unknown" : _func.getinfos().name);

	if (::Tactical.getNavigator().IsTravelling || !_targetTile.IsEmpty)
	{
		if (::Reforged.Mod.Debug.isEnabled("onAnySkillExecutedFully"))
		{
			local prefix = !::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null ? "OTHER -- " : "";
			local reason = !_targetTile.IsEmpty ? "target tile not empty" : "navigator already traveling";
			::Reforged.Mod.Debug.printWarning(format("%sNot scheduling due to %s -- Caller: %s.%s (%s : %i), Callback: %s", prefix, reason, "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		}
		teleport_6(_user, _targetTile, _func, _data, _bool, _float);
		return;
	}

	if (!::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null)
	{
		::Reforged.Mod.Debug.printLog(format("OTHER -- Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		local function wrapper( _arg1, _arg2 )
		{
			::Reforged.Mod.Debug.printLog(format("OTHER -- Triggering teleport Callback - Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg1, _arg2);
			}
		}
		teleport_6(_user, _targetTile, wrapper, _data, _bool, _float);
		return;
	}

	::Reforged.Mod.Debug.printLog(format("Caller: %s.%s (%s : %i), Callback: %s, Count: %i", info.Skill.ClassName, info.Func, info.Src, info.Line, info.Callback, info.Skill.m.RF_Schedule.Count + 1), "onAnySkillExecutedFully");

	teleport_6(_user, _targetTile, getWrapper(info, _func, 2, "teleport"), _data, _bool, _float);
}}.teleport;

local teleport_5 = ::TacticalNavigator["__sqrat_ol_ teleport_5"];
::TacticalNavigator["__sqrat_ol_ teleport_5"] <- { function teleport( _user, _targetTile, _func, _data, _bool )
{
	local info = getSchedulerInfo();
	if (info == null)
	{
		teleport_5(_user, _targetTile, _func, _data, _bool);
		return;
	}

	// This is just put in there for debug printing
	info.Callback <- _func == null ? "null" : (_func.getinfos().name == null ? "unknown" : _func.getinfos().name);

	if (::Tactical.getNavigator().IsTravelling || !_targetTile.IsEmpty)
	{
		if (::Reforged.Mod.Debug.isEnabled("onAnySkillExecutedFully"))
		{
			local prefix = !::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null ? "OTHER -- " : "";
			local reason = !_targetTile.IsEmpty ? "target tile not empty" : "navigator already traveling";
			::Reforged.Mod.Debug.printWarning(format("%sNot scheduling due to %s -- Caller: %s.%s (%s : %i), Callback: %s", prefix, reason, "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		}
		teleport_5(_user, _targetTile, _func, _data, _bool);
		return;
	}

	if (!::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null)
	{
		::Reforged.Mod.Debug.printLog(format("OTHER -- Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		local function wrapper( _arg1, _arg2 )
		{
			::Reforged.Mod.Debug.printLog(format("OTHER -- Triggering teleport Callback - Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg1, _arg2);
			}
		}
		teleport_5(_user, _targetTile, wrapper, _data, _bool);
		return;
	}

	::Reforged.Mod.Debug.printLog(format("Caller: %s.%s (%s : %i), Callback: %s, Count: %i", info.Skill.ClassName, info.Func, info.Src, info.Line, info.Callback, info.Skill.m.RF_Schedule.Count + 1), "onAnySkillExecutedFully");

	teleport_5(_user, _targetTile, getWrapper(info, _func, 2, "teleport"), _data, _bool);
}}.teleport;

local switchEntities = ::TacticalNavigator.switchEntities;
::TacticalNavigator.switchEntities <- { function switchEntities( _user, _targetEntity, _func, _data, _float )
{
	local info = getSchedulerInfo();
	if (info == null)
	{
		switchEntities(_user, _targetEntity, _func, _data, _float);
		return;
	}

	// This is just put in there for debug printing
	info.Callback <- _func == null ? "null" : (_func.getinfos().name == null ? "unknown" : _func.getinfos().name);

	if (::Tactical.getNavigator().IsTravelling)
	{
		if (::Reforged.Mod.Debug.isEnabled("onAnySkillExecutedFully"))
		{
			local prefix = !::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null ? "OTHER -- " : "";
			::Reforged.Mod.Debug.printWarning(format("%sNot scheduling due to navigator already traveling -- Caller: %s.%s (%s : %i), Callback: %s", prefix, reason, "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		}
		switchEntities(_user, _targetEntity, _func, _data, _float);
		return;
	}

	if (!::isKindOf(info.Skill, "skill") || info.Skill.m.RF_Schedule == null)
	{
		::Reforged.Mod.Debug.printLog(format("OTHER -- Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
		local function wrapper( _arg1, _arg2 )
		{
			::Reforged.Mod.Debug.printLog(format("OTHER -- Triggering switchEntities Callback - Caller: %s.%s (%s : %i), Callback: %s", "ClassName" in info.Skill ? info.Skill.ClassName : split(info.Src, "/").top(), info.Func, info.Src, info.Line, info.Callback), "onAnySkillExecutedFully");
			if (_func != null)
			{
				_func(_arg1, _arg2);
			}
		}
		switchEntities(_user, _targetEntity, wrapper, _data, _float);
		return;
	}

	::Reforged.Mod.Debug.printLog(format("Caller: %s.%s (%s : %i), Callback: %s, Count: %i", info.Skill.ClassName, info.Func, info.Src, info.Line, info.Callback, info.Skill.m.RF_Schedule.Count + 1), "onAnySkillExecutedFully");

	// Increase count by 2 because the callback is called for both entities
	local cbEntry = [getWrapper(info, _func, 2, "switchEntities", 2), _data];

	// Vanilla has a bug where switchEntities callbacks don't trigger when outside player vision
	// so we trigger them manually during actor.onMovementFinish instead and set the native callback to null
	_user.m.RF_switchEntitiesCallbacks.push(cbEntry);
	_targetEntity.m.RF_switchEntitiesCallbacks.push(cbEntry);

	switchEntities(_user, _targetEntity, null, null, _float);
}}.switchEntities;

::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onAnySkillExecutedFully <- { function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		local actor = this.getActor();
		// Don't update if using a skill that sets Tile to ID 0 e.g. Rotation because this leads
		// to crashes if any skill tries to access the current tile in its onUpdate
		// function as the tile at this point is not a valid tile.

		this.callSkillsFunctionWhenAlive("onAnySkillExecutedFully", [
			_skill,
			_targetTile,
			_targetEntity,
			_forFree
		], actor.isPlacedOnMap());

		actor.setDirty(true);
	}}.onAnySkillExecutedFully;
});

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.m.RF_Schedule <- null;

	q.onAnySkillExecutedFully <- { function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
	}}.onAnySkillExecutedFully;

	q.use = @(__original) { function use( _targetTile, _forFree = false )
	{
		this.m.RF_Schedule = ::Reforged.SkillSchedule(this, _targetTile, _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null, _forFree);

		// The original MSU events of onBeforeAnySkillExecuted and onAnySkilLExecuted will trigger here`
		local ret = __original(_targetTile, _forFree);

		// If no delayed event was scheduled we trigger the onAnySkillExecutedFully manually
		// Note: We can't just check for .Count == 0 because in fog of war teleport/switchEntities
		// happens immediately without delay, so Count will be 0 here even if those happened and the
		// event would have already been properly handled leading to errors when calling it manually again.
		if (this.m.RF_Schedule != null && !this.m.RF_Schedule.WasScheduled)
		{
			this.m.RF_Schedule.onScheduleComplete({Skill = this});
		}

		return ret;
	}}.use;
});

// This is for debugging only - show a popup to the user to send us the log in cases where the skill schedule
// was not completed.
::Reforged.QueueBucket.VeryLate.push(function() {
	local funcs = [
		"onTurnStart",
		"onTurnEnd"
	];

	::Reforged.HooksMod.hookTree("scripts/skills/skill", function(q) {
		foreach (func in funcs)
		{
			q[func] = @(__original) function()
			{
				__original();
				if (this.m.RF_Schedule != null)
				{
					::logError("Schedule not null for " + this.ClassName);
					::Reforged.Mod.Debug.addPopupMessage("There is important debugging information in the game\'s log. Please send your log.html to the developers for debugging. You can share the file on the Reforged Discord server. Your log.html is found in C:\\Users\\YourName\\Documents\\Battle Brothers\\log.html", ::MSU.Popup.State.Full);
				}
			}
		}
	});

	::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
		// Vanilla has a bug where switchEntities callbacks don't trigger when outside player vision
		// so we trigger them manually during onMovementFinish instead.
		// We use an array because one callback may trigger another and we to support a stack of those.
		q.m.RF_switchEntitiesCallbacks <- [];

		q.onMovementFinish = @(__original) { function onMovementFinish( _tile )
		{
			__original(_tile);
			// Call the switchEntities callbacks from last to first as expected.
			while (this.m.RF_switchEntitiesCallbacks.len() != 0)
			{
				local entry = this.m.RF_switchEntitiesCallbacks.pop();
				entry[0](this, entry[1]);
			}
		}}.onMovementFinish;
	});
});

::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	q.RF_canExecuteSkill <- { function RF_canExecuteSkill()
	{
		return !::Time.hasEventScheduled(::TimeUnit.Virtual) && !::Tactical.getNavigator().IsTravelling;
	}}.RF_canExecuteSkill;

	q.executeEntitySkill = @(__original) { function executeEntitySkill( _activeEntity, _targetTile )
	{
		// Prevent executing a skill while the previously executed skill has not fully finished executing
		// including all its delayed effects
		if (!this.RF_canExecuteSkill())
		{
			::Tactical.EventLog.log(::MSU.Text.colorNegative("Already executing a skill!"));
			return;
		}

		__original(_activeEntity, _targetTile);
	}}.executeEntitySkill;
});
