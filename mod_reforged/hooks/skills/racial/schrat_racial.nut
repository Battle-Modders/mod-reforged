::mods_hookExactClass("skills/racial/schrat_racial", function(o) {
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 2.0;	// In Vanilla this is 1.33 for firelance and 3.0 for burning ground
				break;

			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.50;
				}
				else
				{
					if (_skill.isRanged())
					{
						_properties.DamageReceivedRegularMult *= 0.25;
						/* This streamlines the following differences in vanilla:
							javelins dealing 50% damage
							handgonne and one-use throwing spear dealing 100% damage
						*/
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.50;	// New: In Vanilla piercing melee attacks are not reduced
					}
				}
				break;
		}
	}

	// We exported everything this function does into its own effect (rf_sapling_harvest).
	// By overwriting this method we also nullify all other mods hooking into this before us but there is clean solution to this
	o.onDamageReceived = function( _attacker, _damageHitpoints, _damageArmor ) {};
});
