::Reforged.HooksMod.hook("scripts/skills/actives/strike_skill", function(q) {
	// Overwrite the function provided by mod_modular_vanilla to remove
	// the reduction of AP cost from Polearm Mastery. We instead apply a
	// custom version of that in our hook on perk_mastery_polearm
	q.onAfterUpdate = @() function( _properties )
	{
		if (this.m.ApplyAxeMastery)
		{
			if (_properties.IsSpecializedInAxes)
			{
				this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
			}
		}
		else if (_properties.IsSpecializedInPolearms)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}
});
