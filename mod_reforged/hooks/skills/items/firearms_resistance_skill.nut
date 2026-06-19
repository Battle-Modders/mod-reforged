::Reforged.HooksMod.hook("scripts/skills/items/firearms_resistance_skill", function(q) {
	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		// We revert the vanilla changes to DamageReceivedFireMult, as we implement burning ground resistance in onBeforeDamageReceived now
		local old_DamageReceivedFireMult = _properties.DamageReceivedFireMult;
		__original(_properties);
		_properties.DamageReceivedFireMult = old_DamageReceivedFireMult;
	}}.onUpdate;

	// We overwrite the vanilla behavior of that skill completely while replicating its effect pretty future proof
	q.onBeforeDamageReceived = @() { function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && !::MSU.isNull(_skill.getItem()) && _skill.getItem().isItemType(::Const.Items.ItemType.Weapon) && _skill.getItem().isWeaponType(::Const.Items.WeaponType.Firearm))	// This covers all kinds of firearms
		{
			_properties.DamageReceivedRegularMult *= 0.66;
		}
		else if (_hitInfo.DamageType == ::Const.Damage.DamageType.Burning)  // This covers burning ground and firelances
		{
			_properties.DamageReceivedRegularMult *= 0.66;
		}
	}}.onBeforeDamageReceived;
});
