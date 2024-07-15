::Reforged.HooksMod.hook("scripts/skills/items/firearms_resistance_skill", function(q) {
    // We overwrite the vanilla behavior of that skill completely while replicating its effect pretty future proof
    q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
	{
        if (_skill != null && !::MSU.isNull(_skill.getItem()) && _skill.getItem().isItemType(::Const.Items.ItemType.Weapon) && _skill.getItem().isWeaponType(::Const.Items.WeaponType.Firearm))    // This covers all kinds of firearms
        {
            _properties.DamageReceivedRegularMult *= 0.66;
        }
        else if (_hitInfo.DamageType == ::Const.Damage.DamageType.Burning)  // This covers burning ground and firelances
        {
            _properties.DamageReceivedRegularMult *= 0.66;
        }
	}
});
