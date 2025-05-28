::Reforged.HooksMod.hook("scripts/skills/actives/rupture", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			// Replace vanilla tooltip about bleeding to conform to Reforged bleeding mechanic
			if (entry.id == 8)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("Inflicts [Bleeding|Skill+bleeding_effect] when dealing at least " + ::MSU.Text.colorDamage(::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
				break;
			}
		}
		return ret;
	}}.getTooltip;

	// Overwrite the function provided by mod_modular_vanilla to remove
	// the reduction of AP cost from Polearm Mastery. We instead apply a
	// custom version of that in our hook on perk_mastery_polearm
	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInPolearms)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}}.onAfterUpdate;
});
