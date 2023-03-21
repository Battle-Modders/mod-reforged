::mods_hookExactClass("skills/perks/perk_backstabber", function (o) {
	o.m.IsForceEnabled <- false;
	o.m.DamageBonusPerSurroundCount <- 0.05;

	local create = o.create;
    o.create = function()
    {
        create();
        this.m.Icon = "ui/perks/perk_59.png";   // In vanilla it uses the 'Brawny' Icon but there it doesn't cause issues. However we list this perk in the tactical tooltip.
    }

    o.isEnabled <- function()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			return false;
		}

		return true;
	}

	o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && this.isEnabled() && !_targetEntity.getCurrentProperties().IsImmuneToSurrounding && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.DamageTotalMult *= 1.0 + (this.m.DamageBonusPerSurroundCount * _targetEntity.getSurroundedCount());
		}

	}
});
