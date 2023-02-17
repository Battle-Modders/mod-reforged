::mods_hookExactClass("skills/racial/serpent_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
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
