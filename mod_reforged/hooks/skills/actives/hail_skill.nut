::Reforged.HooksMod.hook("scripts/skills/actives/hail_skill", function(q) {
	q.m.RerollDamageMult <- 1.0;
	q.m.IsAttacking <- false;

	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to hit the head"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make three separate attack rolls for one third of the weapon\'s damage each, combined into one strike"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields but not by [Shieldwall|Skill+shieldwall]")
			});
		}

		return ret;
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
		if (_skill == this)
		{
			_properties.HitChance[::Const.BodyPart.Head] += 100.0;

			if (this.m.IsAttacking)
			{
				_properties.DamageTotalMult *= this.m.RerollDamageMult;		
			}
		}
	}
});
