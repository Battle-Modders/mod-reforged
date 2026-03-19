::Reforged.HooksMod.hook("scripts/skills/actives/ghastly_touch", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Attack the very soul of an opponent, damaging them through their armor.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.skill.getDefaultTooltip();
	}}.getTooltip;

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties)
		if (_skill == this)
		{
			// VanillaFix: Vanilla does not set the Armor Damage of this skill to 0 (unlike they do on Puncture), which causes a confusing skill tooltip
			_properties.DamageArmorMult *= 0.0;
		}
	}
});
