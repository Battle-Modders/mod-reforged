this.rf_hook_shield_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ApplyAxeMastery = true,
		LastTargetID = null,
		IsSpent = false
	},
	function isAxeMasteryApplied()
	{
		return this.m.ApplyAxeMastery;
	}

	function setApplyAxeMastery( _f )
	{
		this.m.ApplyAxeMastery = _f;
	}

	function create()
	{
		this.m.ID = "actives.rf_hook_shield";
		this.m.Name = "Hook Shield";
		this.m.Description = "An attack specifically aimed at hooking an opponent\'s shield. Can only be used against targets that carry a shield. If successful, will reduce the efficacy of the target\'s shield.";
		this.m.Icon = "skills/rf_hook_shield_skill.png";
		this.m.IconDisabled = "skills/rf_hook_shield_skill_sw.png";
		this.m.Overlay = "rf_hook_shield_skill";
		this.m.SoundOnUse = [
			"sounds/combat/hook_01.wav",
			"sounds/combat/hook_02.wav",
			"sounds/combat/hook_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsShieldRelevant = false;
		this.m.IsShieldwallRelevant = false;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsTooCloseShown = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockOut;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Removes [Shieldwall|Skill+shieldwall_effect] from the target. Otherwise applies the [Hooked Shield|Skill+rf_hooked_shield_effect] effect")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Once per [turn,|Concept.Turn] when used against the same target twice, the second use refunds all of its [Action Point|Concept.ActionPoints] cost")
		});

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields and [Shieldwall|Skill+shieldwall_effect]")
		});

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Cannot be used against a target using [Shieldwall|Skill+shieldwall_effect] adjacent to an ally using [Shieldwall|Skill+shieldwall_effect]")
		});

		if (this.getMaxRange() > 1)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorPositive(this.m.MaxRange) + " tiles"
			});
		}

		if (this.getMaxRange() > 1 && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorNegative("-15%") + " chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		if (this.isAxeMasteryApplied() && _properties.IsSpecializedInAxes)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local targetEntity = _targetTile.getEntity();
		if (targetEntity.isAlliedWith(this.getContainer().getActor()))
			return false;

		if (!targetEntity.isArmedWithShield() || !this.skill.onVerifyTarget(_originTile, _targetTile) || targetEntity.getSkills().hasSkill("effects.rf_hooked_shield"))
			return false;

		if (targetEntity.getSkills().hasSkill("effects.shieldwall"))
		{
			foreach (ally in ::Tactical.Entities.getAlliedActors(targetEntity.getFaction(), _targetTile, 1, true))
			{
				if (ally.getSkills().hasSkill("effects.shieldwall"))
				{
					return false;
				}
			}
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (!this.m.IsSpent && targetEntity.getID() == this.m.LastTargetID)
		{
			_user.setActionPoints(::Math.min(_user.getActionPointsMax(), _user.getActionPoints() + this.getActionPointCost()));
			this.m.IsSpent = true;
		}

		this.m.LastTargetID = targetEntity.getID();

		local shield = targetEntity.getOffhandItem();
		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplitShield);
			if (this.attackEntity(_user, targetEntity))
			{
				local shieldWall = targetEntity.getSkills().getSkillByID("effects.shieldwall");
				if (shieldWall != null)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " hooks " + ::Const.UI.getColorizedEntityName(targetEntity) + "\'s shield removing their " + shieldWall.m.Name);
					targetEntity.getSkills().remove(shieldWall);
				}
				else
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " hooks " + ::Const.UI.getColorizedEntityName(targetEntity) + "\'s shield");
					targetEntity.getSkills().add(::new("scripts/skills/effects/rf_hooked_shield_effect"));
				}
				if (!::Tactical.getNavigator().isTravelling(_targetTile.getEntity()))
				{
					::Tactical.getShaker().shake(targetEntity, _user.getTile(), 5, ::Const.Combat.ShakeEffectSplitShieldColor, ::Const.Combat.ShakeEffectSplitShieldHighlight, ::Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
						"shield_icon"
					], 1.0);
				}
				::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
				return true;
			}
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult = 0.0;
			if (this.getMaxRange() > 1)
			{
				if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
				{
					_properties.MeleeSkill += -15;
					this.m.HitChanceBonus = -15;
				}
				else
				{
					this.m.HitChanceBonus = 0;
				}
			}
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill != this || this.m.IsSpent || !_targetTile.IsOccupiedByActor || _targetTile.getEntity().getID() != this.m.LastTargetID)
			return;

		_tooltip.push({
			icon = "ui/icons/action_points.png",
			text = "Refund Action Points on hit"
		});
	}
});
