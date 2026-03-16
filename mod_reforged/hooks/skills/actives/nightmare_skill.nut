::Reforged.HooksMod.hook("scripts/skills/actives/nightmare_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Plunge your target into a world of nightmares and feast upon their souls while they sleep!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can only be used on [$ $|Skill+sleeping_effect] targets")
		});
		return ret;
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
