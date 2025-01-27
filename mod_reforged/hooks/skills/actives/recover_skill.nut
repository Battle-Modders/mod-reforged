::Reforged.HooksMod.hook("scripts/skills/actives/recover_skill", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Cannot be used after movement or having used a skill"
		});

		return ret;
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsUsable = false;
	}

	q.onMovementStarted = @(__original) function( _tile, _numTiles )
	{
		this.m.IsUsable = false;
	}

	q.onTurnStart = @(__original) function()
	{
		__original();
		this.resetField("IsUsable");
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();
		this.resetField("IsUsable");
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		// Ghetto way to show during skill/movement preview that Recover will become unusable
		if (this.getContainer().getActor().isPreviewing())
		{
			this.m.ActionPointCost += 9999;
		}
	}
});
