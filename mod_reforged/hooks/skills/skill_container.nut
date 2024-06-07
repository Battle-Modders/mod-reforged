::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.m.RF_HitInfo <- null;

	q.buildPropertiesForBeingHit = @(__original) function( _attacker, _skill, _hitInfo )
	{
		if (_skill == null)
			return __original(_attacker, _skill, _hitInfo);

		this.m.RF_HitInfo = _hitInfo.weakref();

		_hitInfo.ResilienceDamage = _skill.getResilienceDamage();

		local ret = __original(_attacker, _skill, _hitInfo);

		_hitInfo.ResilienceDamage *= ret.ResilienceDamageReceivedMult;

		return ret;
	}

	q.onDamageReceived = @(__original) function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.RF_HitInfo != null)
		{
			local actor = this.getActor();
			actor.m.Resilience = ::Math.min(actor.getResilienceMax(), this.getResilience() - this.m.RF_HitInfo.ResilienceDamage);
			actor.onResilienceDamageReceived(this.m.RF_HitInfo);
			this.m.RF_HitInfo = null;
		}

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

	q.onTurnStart = @(__original) function()
	{
		this.getActor().m.Resilience = this.getActor().getResilienceMax();
		return __original();
	}

	q.onCombatStarted = @(__original) function()
	{
		this.getActor().m.Resilience = this.getActor().getResilienceMax();
		return __original();
	}
});
