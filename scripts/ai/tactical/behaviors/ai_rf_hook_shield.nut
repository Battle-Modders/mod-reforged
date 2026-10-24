// Hook Shield deals no damage. Its only value is that attacks made against the target before it next acts
// (the Hooked Shield effect expires on the target's turn start or on any skill it uses) hit more often,
// or, against a target in Shieldwall, that the Shieldwall is removed.
// So we estimate, in units of expected damage dealt to the target, how much extra damage the hook enables
// for this character and its allies, subtract the damage of the attacks the AP spent on the hook displaces,
// and only hook when that is a net gain compared to simply attacking.
this.ai_rf_hook_shield <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		Skill = null,
		PossibleSkills = [
			"actives.rf_hook_shield"
		],
		// Minimum net gain, in units of one plain attack, for hooking to be considered at all
		MinNetGain = 0.05,
		// How likely an ally is to get an attack in on the target, depending on its distance to the target
		AllyAdjacentWeight = 1.0,
		AllyNearbyWeight = 0.5,
		AllyNearbyDistance = 3,
		AllyRangedWeight = 0.5,
		// Multiplier on all ally contributions if the target has not acted yet this round. The hook will
		// then expire at the start of the target's turn, so only allies that act before it benefit.
		AllyTargetNotYetActedMult = 0.5,
		// Value (in units of one plain attack) of removing Riposte / disabling Rebuke on the target
		RiposteRemovalValue = 0.2
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_HookShield;
		this.m.Order = ::Const.AI.Behavior.Order.RF_HookShield;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		if (attackSkill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local score = this.getProperties().BehaviorMult[this.m.ID] * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference());
		if (targets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local allies = this.getAgent().getKnownAllies();
		local bestTarget = null;
		local bestScore = 0.0;

		foreach (target in targets)
		{
			if (target.isNonCombatant() || target.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				continue;
			}

			if (!this.m.Skill.isUsableOn(target.getTile()))
			{
				continue;
			}

			local net = this.getNetGain(_entity, target, attackSkill, allies);
			if (net <= this.m.MinNetGain)
			{
				continue;
			}

			// 1 + net: AttackDefault scores Score.Attack * targetValue, i.e. a plain attack is worth "1".
			// Hooking is worth a plain attack plus whatever it nets over the attack it displaces.
			local targetScore = this.queryTargetValue(_entity, target, attackSkill) * (1.0 + net);

			if (::Const.AI.VerboseMode)
			{
				this.logInfo("Hook Shield vs " + target.getName() + ": net gain " + net + " attacks, target score " + targetScore);
			}

			if (targetScore > bestScore)
			{
				bestScore = targetScore;
				bestTarget = target;
			}
		}

		if (bestTarget == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.getTile();
		return ::Const.AI.Behavior.Score.RF_HookShield * score * bestScore;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();

				if (this.m.Skill.getDelay() != 0)
				{
					this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
				}
			}

			this.m.TargetTile = null;
		}

		return true;
	}

	// Returns the net benefit of hooking _target instead of attacking, in units of one plain attack by _entity
	// (value of one plain attack = its hit chance * its expected damage). <= 0 means attacking is at least as good.
	function getNetGain( _entity, _target, _attackSkill, _allies )
	{
		local shield = _target.getOffhandItem();
		if (shield == null)
		{
			return 0.0;
		}

		local hookSkill = this.m.Skill;
		local hookAP = hookSkill.getActionPointCost();
		// A second successful hook on the same target in a turn refunds its AP cost
		if (!hookSkill.m.IsSpent && hookSkill.m.LastTargetID == _target.getID())
		{
			hookAP = 0;
		}

		local ap = _entity.getActionPoints();
		local attackAP = ::Math.max(1, _attackSkill.getActionPointCost());

		local expected = _attackSkill.getExpectedDamage(_target);
		// We can already kill it, just do that
		if (expected.HitpointDamage + expected.DirectDamage >= _target.getHitpoints())
		{
			return 0.0;
		}

		local selfValue = this.getAttackValue(_attackSkill, _target);
		if (selfValue <= 0.0)
		{
			return 0.0;
		}

		local hookChance = hookSkill.getHitchance(_target) * 0.01;
		local shieldwall = _target.getSkills().getSkillByID("effects.shieldwall");
		local targetNotYetActed = !_target.isTurnDone();

		// Extra damage enabled by the hook
		local gain = ::Math.floor((ap - hookAP) / attackAP) * this.getHookedAttackGain(_attackSkill, _target, shield, shieldwall);

		local targetTile = _target.getTile();
		foreach (ally in _allies)
		{
			if (ally.isTurnDone() || ally.getID() == _entity.getID() || ally.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				continue;
			}

			local allySkill = ally.getSkills().getAttackOfOpportunity();
			if (allySkill == null)
			{
				continue;
			}

			local weight = this.getAllyWeight(ally, allySkill, targetTile);
			if (weight <= 0.0)
			{
				continue;
			}

			if (targetNotYetActed)
			{
				weight *= this.m.AllyTargetNotYetActedMult;
			}

			gain += weight * this.getHookedAttackGain(allySkill, _target, shield, shieldwall);
		}

		// Hooked Shield (not the Shieldwall removal) also removes Riposte and disables Rebuke
		if (shieldwall == null && (_target.getSkills().hasSkill("effects.riposte") || _target.getSkills().hasSkill("perk.rf_rebuke")))
		{
			gain += this.m.RiposteRemovalValue * selfValue;
		}

		// Attacks that the AP spent on hooking would otherwise have paid for
		local lostAttacks = ::Math.floor(ap / attackAP) - ::Math.floor((ap - hookAP) / attackAP);

		local net = (hookChance * gain - lostAttacks * selfValue) / selfValue;

		if (this.getStrategy().getStats().AlliesVSEnemiesRatio < 1.0 && net > 0)
		{
			net *= ::Math.maxf(0.5, this.getStrategy().getStats().AlliesVSEnemiesRatio);
		}

		return net;
	}

	// Expected damage of one attack with _skill against _target
	function getAttackValue( _skill, _target )
	{
		local damage = _skill.getExpectedDamage(_target).TotalDamage;
		damage = ::Math.minf(damage, _target.getHitpoints() + _target.getArmor(::Const.BodyPart.Body) + _target.getArmor(::Const.BodyPart.Head));
		return _skill.getHitchance(_target) * 0.01 * damage;
	}

	// Extra expected damage of one attack with _skill against _target if the hook succeeds
	function getHookedAttackGain( _skill, _target, _shield, _shieldwall )
	{
		if (!_skill.m.IsShieldRelevant)
		{
			return 0.0;
		}

		local removed = this.getDefenseRemoved(_skill.isRanged(), _target, _shield, _shieldwall);
		if (removed <= 0)
		{
			return 0.0;
		}

		local chance = _skill.getHitchance(_target);
		local newChance = ::Math.max(::Const.Combat.MV_HitChanceMin, ::Math.min(::Const.Combat.MV_HitChanceMax, chance + removed));
		if (newChance <= chance)
		{
			return 0.0;
		}

		local damage = _skill.getExpectedDamage(_target).TotalDamage;
		damage = ::Math.minf(damage, _target.getHitpoints() + _target.getArmor(::Const.BodyPart.Body) + _target.getArmor(::Const.BodyPart.Head));
		return (newChance - chance) * 0.01 * damage;
	}

	// How much Melee/Ranged Defense the target loses against a skill if hooked
	function getDefenseRemoved( _isRanged, _target, _shield, _shieldwall )
	{
		if (_shieldwall != null)
		{
			// Mirrors shieldwall_effect.onUpdate and getBonus
			if (_shield.getCondition() <= 0)
			{
				return 0;
			}

			local properties = _target.getCurrentProperties();
			local shieldDefense = _isRanged ? _shield.getRangedDefense() : _shield.getMeleeDefense();
			return ::Math.floor(shieldDefense * (properties.IsSpecializedInShields ? 1.25 : 1.0)) + (properties.IsProficientWithShieldSkills ? 5 : 0) + _shieldwall.getBonus();
		}

		// Mirrors rf_hooked_shield_effect.onUpdate
		return ::Math.floor((_isRanged ? _shield.getRangedDefenseBonus() : _shield.getMeleeDefenseBonus()) * 0.75);
	}

	// Likelihood that _ally gets an attack in on the target before the hook expires
	function getAllyWeight( _ally, _allySkill, _targetTile )
	{
		local distance = _ally.getTile().getDistanceTo(_targetTile);
		if (_allySkill.isRanged())
		{
			return distance <= _allySkill.getMaxRange() && distance > 1 ? this.m.AllyRangedWeight : 0.0;
		}

		if (distance == 1)
		{
			return this.m.AllyAdjacentWeight;
		}

		return distance <= this.m.AllyNearbyDistance ? this.m.AllyNearbyWeight : 0.0;
	}
});
