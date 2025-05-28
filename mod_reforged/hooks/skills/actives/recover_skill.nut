::Reforged.HooksMod.hook("scripts/skills/actives/recover_skill", function(q) {
	q.m.HasMovedOrUsedSkill <- false;

	q.getTooltip = @(__original) { function getTooltip()
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
	}}.getTooltip;

	q.onUse = @(__original) { function onUse( _user, _targetTile )
	{
		local ret =__original(_user, _targetTile);
		_user.m.IsTurnDone = true;
		_user.setActionPoints(0);
		return ret;
	}}.onUse;

	q.getFatigueRecovered <- { function getFatigueRecovered()
	{
		return ::Math.ceil(this.getContainer().getActor().getFatigue() * 0.5);
	}}.getFatigueRecovered;

	q.onCostsPreview = @(__original) { function onCostsPreview( _costsPreview )
	{
		__original(_costsPreview);
		if (::MSU.isEqual(this.getContainer().getActor().getPreviewSkill(), this))
		{
			_costsPreview.fatiguePreview -= this.getFatigueRecovered();
		}
	}}.onCostsPreview;

	q.onAnySkillExecuted = @(__original) { function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		this.m.HasMovedOrUsedSkill = true;
	}}.onAnySkillExecuted;

	q.onMovementStarted = @(__original) { function onMovementStarted( _tile, _numTiles )
	{
		__original(_tile, _numTiles);
		this.m.HasMovedOrUsedSkill = true;
	}}.onMovementStarted;

	q.onTurnStart = @(__original) { function onTurnStart()
	{
		__original();
		this.m.HasMovedOrUsedSkill = false;
	}}.onTurnStart;

	q.onCombatFinished = @(__original) { function onCombatFinished()
	{
		__original();
		this.m.HasMovedOrUsedSkill = false;
	}}.onCombatFinished;

	q.isUsable = @(__original) { function isUsable()
	{
		return !this.m.HasMovedOrUsedSkill && __original();
	}}.isUsable;

	// We have to show during preview that it won't be affordable so that the visuals update
	// to show that the skill won't be usable after the previewed action.
	q.isAffordablePreview = @(__original) { function isAffordablePreview()
	{
		return !this.getContainer().getActor().isPreviewing() && __original();
	}}.isAffordablePreview;
});
