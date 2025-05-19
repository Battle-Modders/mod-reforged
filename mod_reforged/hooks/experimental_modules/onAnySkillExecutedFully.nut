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

// We overwrite the three functions `scheduleEvent`, `teleport` and `switchEntities` to add a custom callback function
// that triggers the onScheduleComplete event inside ScheduledSkill class.

local scheduleEvent = ::Time.scheduleEvent;
::Time.scheduleEvent = function( _timeUnit, _time, _func, _data )
{
	local caller = ::getstackinfos(2).locals["this"];
	if (!::isKindOf(caller, "skill") || !(caller in ::Reforged.ScheduleSkills))
	{
		scheduleEvent(_timeUnit, _time, _func, _data);
		return;
	}

	::Reforged.ScheduleSkills[caller].Count++;

	local function scheduledCallbackWrapper( _arg1 )
	{
		if (_func != null)
			_func(_arg1);
		::Reforged.ScheduleSkills[caller].onScheduleComplete();
	}

	scheduleEvent(_timeUnit, _time, scheduledCallbackWrapper, _data);
}

local teleport = ::TacticalNavigator.teleport;
::TacticalNavigator.teleport <- function( _user, _targetTile, _func, _data, _bool, _float = 1.0 )
{
	local caller = ::getstackinfos(2).locals["this"];
	if (!::isKindOf(caller, "skill") || !(caller in ::Reforged.ScheduleSkills))
	{
		teleport(_user, _targetTile, _func, _data, _bool, _float);
		return;
	}

	::Reforged.ScheduleSkills[caller].Count++;

	local function scheduledCallbackWrapper( _arg1, _arg2 )
	{
		if (_func != null)
			_func(_arg1, _arg2);
		::Reforged.ScheduleSkills[caller].onScheduleComplete();
	}

	teleport(_user, _targetTile, scheduledCallbackWrapper, _data, _bool, _float);
}

local switchEntities = ::TacticalNavigator.switchEntities;
::TacticalNavigator.switchEntities <- function( _user, _targetEntity, _func, _data, _float )
{
	local caller = ::getstackinfos(2).locals["this"];
	if (!::isKindOf(caller, "skill") || !(caller in ::Reforged.ScheduleSkills))
	{
		switchEntities(_user, _targetEntity, _func, _data, _float);
		return;
	}

	::Reforged.ScheduleSkills[caller].Count++;

	local function scheduledCallbackWrapper( _arg1, _arg2 )
	{
		if (_func != null)
			_func(_arg1, _arg2);
		::Reforged.ScheduleSkills[caller].onScheduleComplete();
	}

	switchEntities(_user, _targetEntity, scheduledCallbackWrapper, _data, _float);
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
		local scheduleSkill = ::Reforged.ScheduleSkill(this, _targetTile, targetEntity, _forFree);
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
