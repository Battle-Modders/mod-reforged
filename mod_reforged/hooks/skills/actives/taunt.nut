::Reforged.HooksMod.hook("scripts/skills/actives/taunt", function(q) {
	q.m.DefenseModifierFraction <- 0.2;	// This percentage of the users resolve is removed from the targets defense
	q.m.MaxRangeDefenseDebuff <- 1;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.m.DefenseModifierFraction != 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When used on an adjacent target, reduce its Melee Defense and Ranged Defense by " + ::MSU.Text.colorizeFraction(this.m.DefenseModifierFraction) + " of your current Resolve (" + ::MSU.Text.colorizeValue(this.calculateDefenseModifier()) + ")"
			});
		}

		return ret;
	}

	q.onVerifyTarget = @(__original) function( _originTile, _targetTile )
	{
		local ret = __original(_originTile, _targetTile);
		if (ret && _targetTile.getEntity().getSkills().hasSkill("effects.taunted"))	return false;
		return ret;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		__original(_user, _targetTile);

		local target = _targetTile.getEntity();
		if (this.getContainer().getActor().getTile().getDistanceTo(_targetTile) <= this.m.MaxRangeDefenseDebuff)
		{
			local tauntEffect = target.getSkills().getSkillByID("effects.taunted");
			tauntEffect.m.DefenseModifier = this.calculateDefenseModifier();
		}
		target.getSkills().update();	// Otherwise the defense debuff will not be immediately visible in the combat tooltip
	}

// New Functions
	q.calculateDefenseModifier <- function()
	{
		local defenseModifier = -1.0 * this.m.DefenseModifierFraction * this.getContainer().getActor().getCurrentProperties().Bravery;
		return ::Math.min(0, defenseModifier);	// This modifier may never be positive
	}
});
