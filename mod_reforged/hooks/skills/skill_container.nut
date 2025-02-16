::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onDamageReceived = @(__original) function( _attacker, _damageHitpoints, _damageArmor )
	{
		local damage = _damageArmor + ::Math.min(_damageHitpoints, this.getActor().getHitpoints());

		__original(_attacker, _damageHitpoints, _damageArmor);

		if (_attacker != null && damage > 0)
		{
			// We store the damage done by the attacker. This is used to
			// calculate XP distribution when this actor dies.
			local t = this.getActor().m.RF_DamageReceived;

			if (!(_attacker.getFaction() in t)) t[_attacker.getFaction()] <- { Total = 0.0 };
			if (!(_attacker.getID() in t[_attacker.getFaction()])) t[_attacker.getFaction()][_attacker.getID()] <- 0.0;

			t.Total += damage;
			t[_attacker.getFaction()].Total += damage;
			t[_attacker.getFaction()][_attacker.getID()] += damage;
		}
	}

	q.update = @(__original) function()
	{
		__original();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}

	q.onSkillsUpdated <- function()
	{
		this.callSkillsFunctionWhenAlive("onSkillsUpdated", null, false);
	}

	// VanillaFix: A missing 'isNull' in Vanillas implementation causes crashes and glitchy behavior in some situations
	q.querySortedByItems = @(__original) function( _filter, _notFilter = 0 )
	{
		// Instead of overwriting the original function, we clean the WeakTableRefs in every skill, that are no longer valid anyways
		foreach (skill in this.m.Skills)
		{
			if (::MSU.isNull(skill.getItem()))
			{
				// Vanilla only ever checks for '!= null' so that's what we prepare for them here
				// We can't use the setItem function, because some skills have an inferior implementation, that wraps 'null' into a WeakTableRef again
				skill.m.Item = null;
			}
		}

		return __original(_filter, _notFilter);
	}
});
