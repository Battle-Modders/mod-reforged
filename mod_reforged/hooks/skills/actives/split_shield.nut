::Reforged.HooksMod.hook("scripts/skills/actives/split_shield", function(q) {
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (this.getShieldDamage() != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Inflicts " + ::MSU.Text.colorDamage(this.getShieldDamage()) + " damage to shields"
			});
		}

		if (this.RF_getFatigueDamage() != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorDamage(this.RF_getFatigueDamage()) + " [Fatigue|Concept.Fatigue] on the target")
			});
		}

		if (this.getMaxRange() > 1)
		{
			ret.push({
				id = 8,
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

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(this.getShieldDamage());

			if (shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Smash Shield and destroys " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield");
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _targetTile.getEntity().getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Smash Shield and hits " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "\'s shield for [b]" + (conditionBefore - shield.getCondition()) + "[/b] damage");
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
	q.RF_getFatigueDamage <- function()
	{
		return this.getBaseValue("ActionPointCost") <= 4 ? 10 : 20;
	}

	q.getShieldDamage <- function()
	{
		return _user.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).getShieldDamage();
	}
});
