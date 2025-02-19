::Reforged.HooksMod.hook("scripts/skills/actives/whip_skill", function(q) {
	q.getTooltip = @(__original) function()
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
	}
});
