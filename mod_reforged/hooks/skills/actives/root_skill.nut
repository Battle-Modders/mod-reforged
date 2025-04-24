::Reforged.HooksMod.hook("scripts/skills/actives/root_skill", function(q) {
	q.m.Cooldown <- 0;
	q.m.TurnsRemaining <- 0;

	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Raise thick vines from the ground to trap your enemies in place, hampering their ability to move and defend themselves.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
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
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return __original(_user, _targetTile);
	}

	q.isUsable = @() function()
	{
		return this.skill.isUsable() && this.m.TurnsRemaining == 0;
	}

	q.onTurnEnd = @() function()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}
});
