::Reforged.HooksMod.hook("scripts/skills/actives/hail_skill", function(q) {
	q.m.RerollDamageMult <- 1.0;
	q.m.AttackRolls <- [];

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		foreach (entry in ret)
		{
			switch (entry.id)
			{
				// Modify the vanilla 3 separate strikes tooltip to mention our method of three attack rolls but single strike
				case 7:
					entry.text = "Will make three separate attack rolls for one third of the damage each, combined into one strike";
					break;

				// Improve the vanilla entry about ignoring Shields to also mention Shieldwall
				case 8:
					entry.text = ::Reforged.Mod.Tooltips.parseString(format("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields but not by [Shieldwall|Skill+shieldwall_effect]"));
					break;
			}
		}

		return ret;
	}}.getTooltip;

	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla FatigueCost is 25
		// We increase the cost because our 3h flail can potentially combine the entire damage into a single attack
		this.m.FatigueCost = 30;
	}}.create;

	q.onUse = @() { function onUse( _user, _targetTile )
	{
		this.m.RerollDamageMult = 1.0;
		this.m.AttackRolls.clear();

		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();

		local attackInfo = ::MSU.Table.merge(clone ::Const.Tactical.MV_AttackInfo, {
			ChanceToHit = this.getHitchance(target),
			Target = target,
			User = _user,
			PropertiesForUse = this.getContainer().buildPropertiesForUse(this, target),
			PropertiesForDefense = target.getSkills().buildPropertiesForDefense(_user, this)
		});

		for (local i = 0; i < 3; i++)
		{
			local ai = clone attackInfo;
			ai.Roll = ::Math.rand(1, 100);
			this.skill.MV_onAttackRolled(ai);

			local isHit = ai.Roll <= ai.ChanceToHit;
			if (isHit && ::Math.rand(1, 100) <= target.getCurrentProperties().RerollDefenseChance)
			{
				ai.Roll = ::Math.rand(1, 100);
				isHit = ai.Roll <= ai.ChanceToHit;
			}

			if (!isHit)
			{
				this.m.RerollDamageMult -= 0.33;
			}

			this.m.AttackRolls.push(ai.Roll);
		}

		local ret = this.attackEntity(_user, target);
		this.m.AttackRolls.clear();
		return ret;
	}}.onUse;

	q.MV_printAttackToLog = @() { function MV_printAttackToLog( _attackInfo )
	{
		::Tactical.EventLog.log_newline();
		if (this.isUsingHitchance())
		{
			local hitOrMiss = _attackInfo.ChanceToHit != 0 && this.m.RerollDamageMult > 0.1 ? "hits" : "misses";
			::Tactical.EventLog.logEx(format("%s uses %s and %s %s (Chance: %s, Rolled: %s)", ::Const.UI.getColorizedEntityName(_attackInfo.User), this.getName(), hitOrMiss, ::Const.UI.getColorizedEntityName(_attackInfo.Target), _attackInfo.ChanceToHit + "", this.m.AttackRolls.reduce(@(_a, _b) _a + ", " + _b)));
		}
		else
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_attackInfo.User) + " uses " + this.getName() + " and hits " + ::Const.UI.getColorizedEntityName(_attackInfo.Target));
		}
	}}.MV_printAttackToLog;

	q.MV_onAttackRolled = @(__original) { function MV_onAttackRolled( _attackInfo )
	{
		__original(_attackInfo);
		// ChanceToHit can be 0 when target is not IsAbleToDie
		// In this case we don't want to do anything and let vanilla handle it.
		if (_attackInfo.ChanceToHit == 0)
			return;

		// If hit, then set the roll to the average of the success rolls
		// If miss, then set the roll to the average of the miss rolls
		// RerollDamageMult > 0.1 signifies a hit because it drops from 1.0 by -0.33 for every miss
		local rolls = this.m.RerollDamageMult > 0.1 ? this.m.AttackRolls.filter(@(_, _r) _r <= _attackInfo.ChanceToHit) : this.m.AttackRolls.filter(@(_, _r) _r > _attackInfo.ChanceToHit);

		local sum = 0;
		foreach (r in rolls)
		{
			sum += r;
		}
		_attackInfo.Roll = ::Math.floor(sum / rolls.len().tofloat());
	}}.MV_onAttackRolled;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.HitChance[::Const.BodyPart.Head] += 100.0;

			if (this.m.AttackRolls.len() != 0)
			{
				_properties.DamageTotalMult *= this.m.RerollDamageMult;
			}
		}
	}}.onAnySkillUsed;
});
