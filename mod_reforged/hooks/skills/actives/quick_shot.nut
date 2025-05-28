::Reforged.HooksMod.hook("scripts/skills/actives/quick_shot", function(q) {
	q.m.AdditionalAccuracy = 0;
	q.m.AdditionalHitChance = -4;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " arrows left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty quiver of arrows equipped")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}}.getTooltip;

	q.onAfterUpdate = @(__original) { function onAfterUpdate( _properties )
	{
		local additionalAccuracy = this.m.AdditionalAccuracy;
		__original(_properties);
		this.m.AdditionalAccuracy = additionalAccuracy;
	}}.onAfterUpdate;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.05;
			}
		}
	}}.onAnySkillUsed;
});
