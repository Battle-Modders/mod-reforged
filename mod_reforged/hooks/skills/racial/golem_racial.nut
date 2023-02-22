::mods_hookExactClass("skills/racial/golem_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByInjuries = false;
		base.IsAffectedByNight = false;
		base.IsImmuneToBleeding = true;
		base.IsImmuneToDisarm = true;
		base.IsImmuneToFire = true;
		base.IsImmuneToPoison = true;
		base.IsImmuneToStun = true;
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.getID() == "actives.throw_golem")
		{
			_properties.DamageReceivedTotalMult = 0.0;
			return;
		}

		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.1;
				break;

			case ::Const.Damage.DamageType.Blunt:
				if (_skill != null)
				{
					if (_skill.isRanged())	// In Vanilla this reduction only exists for slinging of stones. Here it expands to bolas and potential future blunt ranged attacks
					{
						_properties.DamageReceivedRegularMult *= 0.33;
					}
				}
				break;

			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.5;
				}
				else
				{
					if (_skill.isRanged())
					{
						_properties.DamageReceivedRegularMult *= 0.33;
						/* This streamlines the following differences in vanilla:
							Arrows dealing only 10% damage
							javelins and handgonne dealing only 25% damage
							one-use throwing spear dealing 100% damage
						*/
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.5;
					}
				}
				break;
		}
	}
});
