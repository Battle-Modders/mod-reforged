this.perk_rf_bone_breaker <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Mace,
		RequiredDamageType = ::Const.Damage.DamageType.Blunt,
		IsForceTwoHanded = false,
		IsTargetValid = false,
		InjuryPool = null,
		ChanceOneHanded = 50,
		DamageInflictedHitpoints = 0,
		MinDamageToInflictInjury = 5,
		TargetsThisTurn = [],
		ValidEffects = [
			"effects.sleeping",
			"effects.stunned",
			"effects.net",
			"effects.web",
			"effects.rooted"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_bone_breaker";
		this.m.Name = ::Const.Strings.PerkName.RF_BoneBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BoneBreaker;
		this.m.Icon = "ui/perks/rf_bone_breaker.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Offensive;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.InjuryPool = null;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.InjuryPool = _hitInfo.Injuries;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.DamageInflictedHitpoints = _damageInflictedHitpoints;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.DamageInflictedHitpoints < this.m.MinDamageToInflictInjury || this.m.InjuryPool == null || _targetEntity == null || this.m.TargetsThisTurn.find(_targetEntity.getID()) != null || !_targetEntity.isAlive() || !this.isSkillValid(_skill))
		{
			this.m.InjuryPool = null;
			return;
		}

		if (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.crippling_strikes"))
		{
			this.m.InjuryPool = null;
			return;
		}

		if (_targetEntity.getSkills().getSkillsByFunction((@(skill) this.m.ValidEffects.find(skill.getID()) != null).bindenv(this)).len() > 0)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if ((weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded)) || this.m.IsForceTwoHanded || ::Math.rand(1, 100) <= this.m.ChanceOneHanded)
			{
				this.m.TargetsThisTurn.push(_targetEntity.getID());
				this.applyInjury(_targetEntity);
				this.m.InjuryPool = null;
			}
		}
	}

	function onTurnStart()
	{
		this.m.TargetsThisTurn.clear();
	}

	function onCombatStarted()
	{
		this.m.InjuryPool = null;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TargetsThisTurn.clear();
		this.m.InjuryPool = null;
	}

	function applyInjury( _targetEntity )
	{
		if (_targetEntity.m.CurrentProperties.IsAffectedByInjuries && _targetEntity.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0)
		{
			local injuries = this.m.InjuryPool;
			local potentialInjuries = [];

			foreach( inj in injuries )
			{
				if (!_targetEntity.m.Skills.hasSkill(inj.ID) && _targetEntity.m.ExcludedInjuries.find(inj.ID) == null)
				{
					potentialInjuries.push(inj.Script);
				}
			}

			local appliedInjury = false;

			while (potentialInjuries.len() != 0)
			{
				local r = ::Math.rand(0, potentialInjuries.len() - 1);
				local injury = ::new("scripts/skills/" + potentialInjuries[r]);

				if (injury.isValid(_targetEntity))
				{
					_targetEntity.m.Skills.add(injury);

					if (_targetEntity.isPlayerControlled() && this.isKindOf(_targetEntity, "player"))
					{
						_targetEntity.worsenMood(::Const.MoodChange.Injury, "Suffered an injury");
					}

					if (_targetEntity.isPlayerControlled() || !_targetEntity.isHiddenToPlayer())
					{
						::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_targetEntity) + " suffers " + injury.getNameOnly() + " due to " + ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s Bone Breaker perk!");
					}

					appliedInjury = true;
					break;
				}
				else
				{
					potentialInjuries.remove(r);
				}
			}

			if (appliedInjury)
			{
				_targetEntity.onUpdateInjuryLayer();
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
