::Reforged.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function(q) {
	q.m.AdditionalAccuracy <- 20;
	q.m.AdditionalHitChance <- -15;
	q.m.FatigueDamage <- 40;

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();

		ret.extend(this.getRangedTooltip());

		if (this.m.FatigueDamage != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorDamage(this.m.FatigueDamage) + " [Fatigue|Concept.Fatigue] when hitting a shield")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

	q.onApplyShieldDamage = @(__original) function( _tag )
	{
		if (this.m.FatigueDamage != 0)
		{
			local targetEntity = _tag.TargetTile.getEntity();
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.PropertiesForBeingHit = targetEntity.getCurrentProperties();
			hitInfo.DamageFatigue = this.m.FatigueDamage;
			// calcFatigueDamageReceived is a modular vanilla function.
			targetEntity.setFatigue(::Math.min(targetEntity.getFatigueMax(), targetEntity.getFatigue() + targetEntity.calcFatigueDamageReceived(this, hitInfo)));
		}

		return __original(_tag);
	}
});
