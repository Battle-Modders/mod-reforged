::logWarning("------ Applying Reforged modifications to MSU ------");

::Reforged.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
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

::logWarning("------ Reforged modifications to MSU Finished------");
