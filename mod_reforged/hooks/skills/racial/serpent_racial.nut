::mods_hookExactClass("skills/racial/serpent_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByNight = false;
		base.IsImmuneToDisarm = true;
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.66;
				break;

			// In Vanilla they also take reduced damage from firearms and mortars. But those are currently not covered here
		}
	}
});
