::logWarning("------ Applying Reforged modifications to MSU ------");

::logInfo("Reforged::MSU -- adding ::MSU.new");
::MSU.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
}

::logInfo("Reforged::MSU -- adding ::MSU.Time.getSecondsRequiredToTravel");
::MSU.Time <- {
	function getSecondsRequiredToTravel( _numTiles, _speed, _onRoadOnly = false )	// This is a close copy of how vanilla calculates their distance duration
	{
		_speed *= ::Const.World.MovementSettings.GlobalMult;
		if (_onRoadOnly) _speed *= ::Const.World.MovementSettings.RoadMult;
		return _numTiles * 170.0 / _speed;
	}
}

::logInfo("Reforged::MSU -- adding onSkillsUpdated event");
::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.update = @(__original) function()
	{
		__original();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}

	q.onSkillsUpdated <- function()
	{
		this.callSkillsFunctionWhenAlive("onSkillsUpdated", null, false);

		local shouldUpdate = this.m.SkillsToAdd.len() > 0;
		if (!shouldUpdate)
		{
			foreach (skill in this.m.Skills)
			{
				if (skill.isGarbage())
				{
					shouldUpdate = true;
					break;
				}
			}
		}

		if (shouldUpdate) this.update();
	}
});

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.onSkillsUpdated <- function()
	{
	}
})

::logInfo("Reforged::MSU -- adding ::MSU.Array.removeValues");
::MSU.Array.removeValues <- function( _array, _values )
{
	for (local i = _array.len() - 1; i > 0; i--)
	{
		if (_values.find(_array[i]) != null)
		{
			_array.remove(i);
		}
	}
}

::logWarning("------ Reforged modifications to MSU Finished------");
