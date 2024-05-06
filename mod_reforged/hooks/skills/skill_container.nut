::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onDeathWithInfo = @(__original) function( _killer, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		__original(this.getActor().m.RF_RealKiller, _skill, _deathTile, _corpseTile, _fatalityType);
	}

	q.onOtherActorDeath = @(__original) function( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		__original(this.getActor().m.RF_RealKiller, _victim, _skill, _deathTile, _corpseTile, _fatalityType);
	}

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
});
