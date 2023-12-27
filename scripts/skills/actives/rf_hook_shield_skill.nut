this.rf_hook_shield_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ApplyAxeMastery = true
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
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockOut;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Applies the [Hooked Shield|Skill+rf_hooked_shield_effect] effect on the target")
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields")
		});

		if (this.getMaxRange() > 1)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + ::Const.UI.Color.PositiveValue + "] " + this.m.MaxRange + "[/color] tiles"
			});
		}

		if (this.getMaxRange() > 1 && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + ::Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = this.isAxeMasteryApplied() && _properties.IsSpecializedInAxes ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local targetEntity = _targetTile.getEntity();
		return targetEntity.isArmedWithShield() && this.skill.onVerifyTarget(_originTile, _targetTile) && !targetEntity.getSkills().hasSkill("effects.shieldwall") && !targetEntity.getSkills().hasSkill("effects.rf_hooked_shield");
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local shield = targetEntity.getOffhandItem();
		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplitShield);
			if (this.attackEntity(_user, targetEntity))
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " hooks " + ::Const.UI.getColorizedEntityName(targetEntity) + "\'s shield");
				targetEntity.getSkills().add(::new("scripts/skills/effects/rf_hooked_shield_effect"));
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
});
