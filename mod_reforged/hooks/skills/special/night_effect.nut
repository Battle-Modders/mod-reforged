::Reforged.HooksMod.hook("scripts/skills/special/night_effect", function(q) {
	q.m.HitChancePerTile <- -10;
	q.m.RangedDefenseMult <- 0.7;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 12 && entry.icon == "ui/icons/ranged_skill.png")
			{
				entry.text = "Has " + ::MSU.Text.colorizeValue(this.m.HitChancePerTile, {AddSign = true, AddPercent = true}) + " chance to hit per tile of distance"
			}
		}
		return ret;
	}}.getTooltip;

	q.onGetHitFactors = @(__original) { function onGetHitFactors( _skill, _targetTile, _tooltip )
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
	}}.onGetHitFactors;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		local oldRangedSkillMult = _properties.RangedSkillMult;
		local oldRangedDefense = _properties.RangedDefense;
		__original(_properties);
		_properties.RangedSkillMult = oldRangedSkillMult;	// Prevent Vanilla from changing the Ranged Skill
		_properties.RangedDefense = oldRangedDefense;	// VanillaFix: Vanilla manipulates the flat RangedDefense directly, which will cause wrong effects on characters with negative base ranged defense

		if (_properties.IsAffectedByNight)
		{
			_properties.HitChanceAdditionalWithEachTile += this.m.HitChancePerTile;
			_properties.RangedDefenseMult *= this.m.RangedDefenseMult;
		}
	}}.onUpdate;
});
