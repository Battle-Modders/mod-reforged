::Reforged.HooksMod.hook("scripts/skills/actives/recover_skill", function(q) {
	q.m.HasMovedOrUsedSkill <- false

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will end your [turn|Concept.Turn]")
		});

		local warning = "Cannot be used after movement or having used a skill"
		local colorNegative = this.m.HasMovedOrUsedSkill || !::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().isPreviewing();
		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/warning.png",
			text = colorNegative ? ::MSU.Text.colorNegative(warning) : warning
		});

		return ret;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local ret =__original(_user, _targetTile);
		_user.m.IsTurnDone = true;
		return ret;
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		this.m.HasMovedOrUsedSkill = true;
	}

	q.onMovementStarted = @(__original) function( _tile, _numTiles )
	{
		__original(_tile, _numTiles);
		this.m.HasMovedOrUsedSkill = true;
	}

	q.onTurnStart = @(__original) function()
	{
		__original();
		this.m.HasMovedOrUsedSkill = false;
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();
		this.m.HasMovedOrUsedSkill = false;
	}

	// We have to return true during previewing otherwise the affordability preview system
	// does not update the visuals during preview.
	q.isUsable = @(__original) function()
	{
		return this.getContainer().getActor().isPreviewing() || !this.m.HasMovedOrUsedSkill && __original();
	}

	// We have to show during preview that it won't be affordable so that the visuals update
	// to show that the skill won't be usable after the previewed action.
	q.isAffordablePreview = @(__original) function()
	{
		return __original() && !this.getContainer().getActor().isPreviewing();
	}
});
