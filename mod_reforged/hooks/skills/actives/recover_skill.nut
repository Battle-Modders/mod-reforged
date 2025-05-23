::Reforged.HooksMod.hook("scripts/skills/actives/recover_skill", function(q) {
	q.m.HasMovedOrUsedSkill <- false;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will set your [Action Points|Concept.ActionPoints] to " + ::MSU.Text.colorNegative(0) + " and end your [turn|Concept.Turn]")
		});

		local warning = "Cannot be used after movement or having used a skill";
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
		_user.setActionPoints(0);
		return ret;
	}

	q.getFatigueRecovered <- function()
	{
		return ::Math.ceil(this.getContainer().getActor().getFatigue() * 0.5);
	}

	q.onCostsPreview = @(__original) function( _costsPreview )
	{
		__original(_costsPreview);
		if (::MSU.isEqual(this.getContainer().getActor().getPreviewSkill(), this))
		{
			_costsPreview.fatiguePreview -= this.getFatigueRecovered();
		}
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

	q.isUsable = @(__original) function()
	{
		return !this.m.HasMovedOrUsedSkill && __original();
	}

	// We have to show during preview that it won't be affordable so that the visuals update
	// to show that the skill won't be usable after the previewed action.
	q.isAffordablePreview = @(__original) function()
	{
		return !this.getContainer().getActor().isPreviewing() && __original();
	}
});
