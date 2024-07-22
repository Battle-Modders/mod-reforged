::Reforged.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function(q) {
	q.m.AdditionalAccuracy <- 20;
	q.m.AdditionalHitChance <- -15;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Hurl a throwing spear at a target to inflict devastating damage. Can not be used while engaged in melee."; // Remove the part about damaging shields
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();

		ret.extend(this.getRangedTooltip());

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used because this character is engaged in melee")
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

	// Remove the part about damaging the shield
	q.onUse = @() function( _user, _targetTile )
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		_user.getItems().unequip(_user.getMainhandItem());
		return true;
	}
});
