::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.m.__RF_SkillCount <- 0;
	q.m.__RF_LastTargetID <- 0;
	q.m.__RF_LastAttackerID <- 0;

	// Is used to prevent effects from triggering multiple times from multiple hits/misses in the same attack.
	// The logic is derived from how vanilla does it in perk_overwhelm.
	// Returns true if Const.SkillCounter has progressed since last time this function was called OR if the target is different.
	// Returns false otherwise.
	// Note for use: When using inside a function, this should be called as late as possible but IMMEDIATELY BEFORE
	// applying the effects for which it is intended to prevent them from triggering multiple times.
	// Pass `_false` for `_isAttacker` when the skill user is the actor of this container and the target is `_entity`.
	// Pass `true` for `_isAttacker` if the actor of this container is the target and `_entity` is the attacker.
	q.RF_isNewSkillUseOrEntity <- { function RF_isNewSkillUseOrEntity( _entity, _isAttacker = false )
	{
		local id = _entity == null ? 0 : _entity.getID();
		if (::Const.SkillCounter == this.m.__RF_SkillCount && id == (_isAttacker ? this.m.__RF_LastAttackerID : this.m.__RF_LastTargetID))
		{
			return false;
		}

		this.m.__RF_SkillCount = ::Const.SkillCounter;
		if (_isAttacker)
		{
			this.m.__RF_LastAttackerID = id;
		}
		else
		{
			this.m.__RF_LastTargetID = id;
		}

		return true;
	}}.RF_isNewSkillUseOrEntity;

	q.onDamageReceived = @(__original) { function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
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
	}}.onDamageReceived;

	q.update = @(__original) { function update()
	{
		__original();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}}.update;

	q.onSkillsUpdated <- { function onSkillsUpdated()
	{
		this.callSkillsFunctionWhenAlive("onSkillsUpdated", null, false);
	}}.onSkillsUpdated;

	// Hook MSU function to move Warning tooltip entries to the end of tooltips.
	q.onQueryTooltip = @(__original) { function onQueryTooltip( _skill, _tooltip )
	{
		local ret = __original(_skill, _tooltip);
		local warnings = [];
		for (local i = _tooltip.len() - 1; i >= 0; i--)
		{
			local entry = _tooltip[i];
			if ("icon" in entry && (entry.icon == "ui/icons/warning.png" || entry.icon == "ui/tooltips/warning.png"))
			{
				warnings.push(_tooltip.remove(i));
			}
		}
		_tooltip.extend(warnings);
		return ret;
	}}.onQueryTooltip;
});
