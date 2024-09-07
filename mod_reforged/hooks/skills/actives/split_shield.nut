::Reforged.HooksMod.hook("scripts/skills/actives/split_shield", function(q) {
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (::MSU.isNull(this.getContainer()) || this.getContainer().getActor().getMainhandItem() == null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Inflicts damage to shields"
			});
		}
		else
		{
			local shieldDamage = this._RF_getShieldDamage();
			if (shieldDamage != 0)
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = format("Inflicts %s damage to shields", ::MSU.Text.colorDamage(shieldDamage))
				});
			}
		}

		if (this.RF_getFatigueDamage() != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + this.RF_getFatigueDamage() + "[/color] [Fatigue|Concept.Fatigue] on the target")
			});
		}

		if (this.getMaxRange() > 1)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorPositive(this.m.MaxRange) + " tiles"
			});
		}

		return ret;
	}

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Smash Shield";
		this.m.Description = "An attack specifically aimed at an opponent\'s shield. Can only be used against targets that carry a shield. Will always hit and do damage to the shield, while tiring the target.";
	}

	// We overwrite the original function to remove the part about increased damage to shields from axe mastery
	// and to output Smash Shield instead of Split Shield to the combat log. The rest is the same as vanilla.
	q.onUse = @() function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity()
		local shield = targetEntity.getOffhandItem();

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplitShield);
			local damage = this.RF_getShieldDamage(targetEntity);

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);

			if (shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and destroys " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield");
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					::Sound.play(::MSU.Array.rand(this.m.SoundOnHit), ::Const.Sound.Volume.Skill, _targetTile.getEntity().getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " and hits " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield for [b]" + (conditionBefore - shield.getCondition()) + "[/b] damage");
				}
			}

			if (!::Tactical.getNavigator().isTravelling(_targetTile.getEntity()))
			{
				::Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 2, ::Const.Combat.ShakeEffectSplitShieldColor, ::Const.Combat.ShakeEffectSplitShieldHighlight, ::Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), ::Const.BodyPart.Body, 0, 0);
			}

			// Similar calculation for fatigue damage as in the vanilla actor.nut onDamageReceived function
			local targetProperties = targetEntity.getCurrentProperties();
			local fatigueDamage = this.RF_getFatigueDamage() * targetProperties.FatigueEffectMult;
			if (fatigueDamage != 0)
			{
				targetEntity.setFatigue(::Math.min(targetEntity.getFatigueMax(), ::Math.round(targetEntity.getFatigue() + fatigueDamage * targetProperties.FatigueReceivedPerHitMult * targetProperties.FatigueLossOnAnyAttackMult)));
			}
		}

		return true;
	}

// New Functions
	// Returns the shield damage dealt by this skill
	// Returns 0 if no shield damage could be retrieved
	q.RF_getShieldDamage <- function( _targetEntity = null )
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return 0; // return a non-zero number so the tooltip gets added

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null ? 0 : weapon.getShieldDamage();
	}

	q.RF_getFatigueDamage <- function()
	{
		return this.getBaseValue("ActionPointCost") <= 4 ? 10 : 20;
	}
});
