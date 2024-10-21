::Reforged.HooksMod.hook("scripts/skills/actives/cascade_skill", function(q) {
	q.m.RerollDamageMult <- 1.0;
	q.m.IsAttacking <- false;

	q.create = @(__original) function()
	{
		__original();
		// Vanilla FatigueCost is 13
		// We increase the cost because our 3h flail can potentially combine the entire damage into a single attack
		this.m.FatigueCost = 15;
	}

	q.onUse = @() function( _user, _targetTile )
	{
		this.m.RerollDamageMult = 1.0;
		this.m.IsUsingHitchance = true;

		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();

		local hitChance = this.getHitchance(target);
		for (local i = 0; i < 2; i++)
		{
			local roll = ::Math.rand(1, 100);
			if (roll <= hitChance)
			{
				this.m.IsUsingHitchance = false;
				break;
			}

			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and misses " + ::Const.UI.getColorizedEntityName(target) + " (Chance: " + hitChance + ", Rolled: " + roll + ")");

			this.m.RerollDamageMult -= 0.33;
		}

		this.m.IsAttacking = true;
		local ret = this.attackEntity(_user, target);
		this.m.IsAttacking = false;
		this.m.IsUsingHitchance = true;

		// Play an additional sound effect, if we hit more than once
		if (ret && this.m.RerollDamageMult > 0.5)
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, this.onPlayHitSound.bindenv(this), {
				Sound = ::MSU.Array.rand(this.m.SoundOnHit),
				Pos = target.getPos()
			});
		}

		return ret;
	}

	// Set IsUsingHitChance to true before target hit so that the Nimble perk works properly
	q.onBeforeTargetHit <- function( _skill, _targetEntity, _hitInfo )
	{
		this.m.IsUsingHitchance = true;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.IsAttacking)
		{
			_properties.DamageTotalMult *= this.m.RerollDamageMult;
		}
	}
});
