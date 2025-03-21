::Reforged.HooksMod.hook("scripts/skills/actives/cascade_skill", function(q) {
	q.m.RerollDamageMult <- 1.0;
	q.m.IsAttacking <- false;

	q.getTooltip = @(__original) function()
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
	}

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
