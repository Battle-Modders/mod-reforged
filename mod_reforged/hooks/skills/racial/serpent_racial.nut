::mods_hookExactClass("skills/racial/serpent_racial", function(o) {
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.66;
				break;
		}
	}
});
