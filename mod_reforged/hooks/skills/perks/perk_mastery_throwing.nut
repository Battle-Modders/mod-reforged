::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_throwing", function(q) {
	q.getHitchanceBonus <- function()
	{
		return ::Math.floor(0.20 * this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged() || !_skill.m.IsWeaponSkill) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing)) return;

		_properties.RangedSkill += this.getHitchanceBonus();

		local distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		if (distance <= 2)
		{
			_properties.DamageTotalMult	*= 1.3;
		}
		else if (distance <= 3)
		{
			_properties.DamageTotalMult	*= 1.2;
		}
	}

	q.onQueryTooltip <- function( _skill, _tooltip )
	{
		if (_skill.isRanged() && _skill.m.IsWeaponSkill)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				_tooltip.push({
					id = 10,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has " + ::MSU.Text.colorizePercentage(this.getHitchanceBonus()) + " chance to hit due to " + this.getName()
				});
			}
		}
	}
});
