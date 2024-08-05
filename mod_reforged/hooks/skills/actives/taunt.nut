::Reforged.HooksMod.hook("scripts/skills/actives/taunt", function(q) {
	q.m.DefenseModifierFraction <- 0.2;	// This percentage of the users resolve is removed from the targets defense
	q.m.MaxRangeForDefenseDebuff <- 1;	// The target of your taunt must be at most this many tiles from you to receive the defense debuff

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.m.DefenseModifierFraction != 0)
		{
			if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("When used on an adjacent target, reduces its [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] by " + ::MSU.Text.colorizePct(this.m.DefenseModifierFraction) + " of your current [Resolve|Concept.Bravery]")
				});
			}
			else
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("When used on an adjacent target, reduces its [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] by " + ::MSU.Text.colorizeValue(this.calculateDefenseModifier()) + " (" + ::MSU.Text.colorizePct(this.m.DefenseModifierFraction) + " of your current [Resolve|Concept.Bravery])")
				});
			}
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
		local ret = __original(_user, _targetTile);
		if (!ret) return ret;

		local target = _targetTile.getEntity();
		if (this.getContainer().getActor().getTile().getDistanceTo(_targetTile) <= this.m.MaxRangeForDefenseDebuff)
		{
			local tauntEffect = target.getSkills().getSkillByID("effects.taunted");
			tauntEffect.m.DefenseModifier = this.calculateDefenseModifier();
		}
		target.getSkills().update();	// Otherwise the defense debuff will not be immediately visible in the combat tooltip

		return true;
	}

// New Functions
	q.calculateDefenseModifier <- function()
	{
		local defenseModifier = -1.0 * this.m.DefenseModifierFraction * this.getContainer().getActor().getCurrentProperties().getBravery();
		return ::Math.min(0, defenseModifier);	// This modifier may never be positive
	}
});
