::Reforged.HooksMod.hook("scripts/skills/special/night_effect", function(q) {
	q.m.HitChancePerTile <- -10;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 12 && entry.icon == "ui/icons/ranged_skill.png")
			{
				entry.text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChancePerTile) + " chance to hit per tile of distance"
			}
		}
		return ret;
	}

	q.onGetHitFactors = @(__original) function( _skill, _targetTile, _tooltip )
	{
		__original(_skill, _targetTile, _tooltip);

		if (_skill.isAttack() && _skill.isRanged() && !this.isHidden())
		{
			local malus = this.m.HitChancePerTile * (this.getContainer().getActor().getTile().getDistanceTo(_targetTile) - _skill.getMinRange());
			if (malus != 0)
			{
				_tooltip.push({
					icon = "ui/tooltips/negative.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(malus, {AddPercent = true}) + " [Nighttime|Skill+night_effect]")
				});
			}
		}
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local oldRangedSkillMult = _properties.RangedSkillMult;
		__original(_properties);
		_properties.RangedSkillMult = oldRangedSkillMult;	// Prevent Vanilla from changing the Ranged Skill

		if (_properties.IsAffectedByNight)
		{
			_properties.HitChanceAdditionalWithEachTile += this.m.HitChancePerTile;
		}
	}
});
