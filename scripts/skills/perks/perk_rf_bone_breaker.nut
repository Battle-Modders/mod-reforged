this.perk_rf_bone_breaker <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Mace,
		RequiredDamageType = ::Const.Damage.DamageType.Blunt,
		IsForceTwoHanded = false,
		ChanceOneHanded = 50,
		MinDamageToInflictInjury = 5,
		ValidEffects = [
			"effects.sleeping",
			"effects.stunned",
			"effects.net",
			"effects.web",
			"effects.rooted"
		],

		__TargetsThisTurn = [],
		__HitInfo = null
	},
	function create()
	{
		this.m.ID = "perk.rf_bone_breaker";
		this.m.Name = ::Const.Strings.PerkName.RF_BoneBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BoneBreaker;
		this.m.Icon = "ui/perks/perk_rf_bone_breaker.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Offensive;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.__HitInfo = _hitInfo;
	}

	// TODO: Properly handle delayed attacks
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.__HitInfo == null || _targetEntity == null || this.m.__TargetsThisTurn.find(_targetEntity.getID()) != null || !_targetEntity.isAlive() || !this.isSkillValid(_skill))
		{
			this.m.__HitInfo = null;
			return;
		}

		if (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.crippling_strikes"))
		{
			this.m.__HitInfo = null;
			return;
		}

		local validEffects = this.m.ValidEffects;
		if (_targetEntity.getSkills().getSkillsByFunction((@(skill) validEffects.find(skill.getID()) != null)).len() != 0)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if ((weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded)) || this.m.IsForceTwoHanded || ::Math.rand(1, 100) <= this.m.ChanceOneHanded)
			{
				if (!this.getContainer().RF_validateSkillCounter(_targetEntity))
				{
					this.m.__HitInfo = null;
					return;
				}

				this.m.__TargetsThisTurn.push(_targetEntity.getID());
				_targetEntity.MV_applyInjury(_skill, this.m.__HitInfo);
			}
		}

		this.m.__HitInfo = null;
	}

	function onTurnStart()
	{
		this.m.__TargetsThisTurn.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.__TargetsThisTurn.clear();
		this.m.__HitInfo = null;
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
