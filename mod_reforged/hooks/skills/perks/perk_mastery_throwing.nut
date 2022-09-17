::mods_hookExactClass("skills/perks/perk_mastery_throwing", function (o) {
	o.getHitchanceBonus <- function()
	{
		return ::Math.floor(0.20 * this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged() || !_skill.m.IsWeaponSkill) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing)) return;

		local distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		if (distance <= 3)
		{
			_properties.RangedSkill += this.getHitchanceBonus();
			_properties.DamageTotalMult	*= 1.2;
		}
	}

	o.onQueryTooltip <- function( _skill, _tooltip )
	{
		if (_skill.isRanged() && _skill.m.IsWeaponSkill)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				tooltip.push({
					id = 10,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has " + ::MSU.Text.colorizePercentage(this.getHitchanceBonus()) + " chance to hit at a distance of 3 tiles or less"
				});
			}
		}
	}
});
