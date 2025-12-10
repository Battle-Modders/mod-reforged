::Reforged.HooksMod.hook("scripts/skills/actives/crush_armor", function(q) {
	q.create = @(__original) { function create()
	{
		__original();

		// Add Blunt Damage type to the skill so it works properly with perks
		// that require Blunt damage. In vanilla this skill doesn't apply
		// any injuries so MSU doesn't assign it a damage type.
		if (this.m.DamageType.len() == 0)
			this.m.DamageType.add(::Const.Damage.DamageType.Blunt);
	}}.create;
});
