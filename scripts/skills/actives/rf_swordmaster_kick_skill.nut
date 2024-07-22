this.rf_swordmaster_kick_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_active_abstract", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_swordmaster_kick";
		this.m.Name = "Kick";
		this.m.Description = "Kick an enemy, knocking them back and staggering them!";
		this.m.Icon = "skills/rf_swordmaster_kick_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_kick_skill_sw.png";
		this.m.Overlay = "rf_swordmaster_kick_skill";
		this.m.SoundOnUse = [
			"sounds/combat/knockback_01.wav",
			"sounds/combat/knockback_02.wav",
			"sounds/combat/knockback_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockBack;
	}

	function getTooltip()
	{
		local tooltip = this.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorPositive("100%") + " chance to stagger the target"
		});

		local attack = this.getContainer().getAttackOfOpportunity();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Perform a free [%s|Skill+%s] on the target", attack.getName(), split(::IO.scriptFilenameByHash(attack.ClassNameHash), "/").top()))
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the attack is successful, the target is pushed back a tile"
		});

		this.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted || _targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		target.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has kicked and staggered " + ::Const.UI.getColorizedEntityName(target));
		}

		local aoo = this.getContainer().getAttackOfOpportunity();
		local overlay = aoo.m.Overlay;
		aoo.m.Overlay = "";
		local success = aoo.useForFree(_targetTile);
		aoo.m.Overlay = overlay;

		if (success && target.isAlive())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
			}

			local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
			if (knockToTile == null)
			{
				return success;
			}

			this.applyFatigueDamage(target, 10);

			local skills = target.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");

			if (this.m.SoundOnHit.len() != 0)
			{
				::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
			}

			target.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);
			local damage = ::Math.max(0, ::Math.abs(knockToTile.Level - _targetTile.Level) - 1) * ::Const.Combat.FallingDamage;

			if (damage == 0)
			{
				::Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone ::Const.Tactical.HitInfo,
					HitInfoBash = null
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;

				::Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
			}
		}

		return success;
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}

		if (_tag.HitInfoBash != null)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfoBash);
		}
	}

});

