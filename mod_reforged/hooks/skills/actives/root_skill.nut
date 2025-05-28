::Reforged.HooksMod.hook("scripts/skills/actives/root_skill", function(q) {
	q.m.Cooldown <- 0;
	q.m.TurnsRemaining <- 0;

	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Raise thick vines from the ground to trap your enemies in place, hampering their ability to move and defend themselves.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target and all adjacent enemies receive the [Rooted|Skill+rooted_effect] effect")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		return ret;
	}}.getTooltip;

	q.onUse = @(__original) { function onUse( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return __original(_user, _targetTile);
	}}.onUse;

	q.isUsable = @() { function isUsable()
	{
		return this.skill.isUsable() && this.m.TurnsRemaining == 0;
	}}.isUsable;

	q.onTurnEnd = @() { function onTurnEnd()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}}.onTurnEnd;
});
