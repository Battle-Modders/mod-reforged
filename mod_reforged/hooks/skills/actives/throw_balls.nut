::Reforged.HooksMod.hook("scripts/skills/actives/throw_balls", function(q) {
	q.m.AdditionalAccuracy <- 20;
	q.m.AdditionalHitChance <- -15;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.FatigueCost = 12;
		this.m.IsShieldRelevant = false;		// Bolas now ignore the defense bonus of shields as a new unique ability
	}}.create;

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
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " spiked balls left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("No spiked balls left")
			});
		}

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores the bonus to [Ranged Defense|Concept.RangeDefense] granted by shields")
		});

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

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}}.onAnySkillUsed;
});
