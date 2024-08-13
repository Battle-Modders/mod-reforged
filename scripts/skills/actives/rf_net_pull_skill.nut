this.rf_net_pull_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_net_pull";
		this.m.Name = "Net Pull";
		this.m.Description = "Use your net to pull a target close and ensnare them.";
		this.m.Icon = "skills/rf_net_pull_skill.png";
		this.m.IconDisabled = "skills/rf_net_pull_skill_sw.png";
		this.m.Overlay = "rf_net_pull_skill";
		this.m.SoundOnUse = [
			"sounds/combat/hook_01.wav",
			"sounds/combat/hook_02.wav",
			"sounds/combat/hook_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hook_hit_01.wav",
			"sounds/combat/hook_hit_02.wav",
			"sounds/combat/hook_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockBack;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorPositive("2") + " tiles"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorPositive("100%") + " chance to [net|Skill+net_effect] and [stagger|Skill+staggered_effect] on a hit")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target will lose the [Shieldwall|Skill+shieldwall_effect], [Spearwall+Skill+spearwall_effect] and [Riposte|Skill+riposte_effect] effects")
		});
		ret.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will expend the currently held net"
		});
		return ret;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		return this.getPulledToTile(_userTile, _targetTile);
	}

	function getPulledToTile( _userTile, _targetTile )
	{
		local dir = _targetTile.getDirectionTo(_userTile);

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = _targetTile.getDirectionTo(_userTile);
		dir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		return null;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local targetProperties = _targetTile.getEntity().getCurrentProperties();
		return !targetProperties.IsRooted && !targetProperties.IsImmuneToKnockBackAndGrab && !targetProperties.IsImmuneToRoot && this.getPulledToTile(_originTile, _targetTile) != null;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		local pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);

		if (pullToTile == null || target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " pulls and nets " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()));
		}

		local skills = _targetTile.getEntity().getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (this.m.SoundOnHit.len() != 0)
		{
			::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
		}

		target.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);
		local damage = ::Math.max(0, ::Math.abs(pullToTile.Level - _targetTile.Level) - 1) * ::Const.Combat.FallingDamage;
		local tag = {
			Attacker = _user,
			Skill = this,
			HitInfo = clone ::Const.Tactical.HitInfo,
			TargetTile = pullToTile
		};

		if (damage == 0)
		{
			::Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onHookingComplete, tag, true);
		}
		else
		{
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
			::Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onPulledDown, tag, true);
		}

		return true;
	}

	function onPulledDown( _entity, _tag )
	{
		_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);

		if (_entity.isAlive())
		{
			_tag.Attacker.getSkills().getSkillByID("actives.throw_net").useForFree(_tag.TargetTile);
			_entity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		}
	}

	function onHookingComplete( _entity, _tag )
	{
		_tag.Attacker.getSkills().getSkillByID("actives.throw_net").useForFree(_tag.TargetTile);
		_entity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		_tag.Attacker.setDirty(true);
	}
});
