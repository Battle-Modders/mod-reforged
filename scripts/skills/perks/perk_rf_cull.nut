this.perk_rf_cull <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Threshold = 0.33,
		SkillCount = 0,
		LastTargetID = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_cull";
		this.m.Name = ::Const.Strings.PerkName.RF_Cull;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Cull;
		this.m.Icon = "ui/perks/rf_cull.png";
		this.m.IconMini = "rf_cull_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getContainer().getActor().isPlayerControlled();
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			return false;
		}

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != ::Const.BodyPart.Head || !_skill.isAttack() || !this.isEnabled() || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getSkills().hasSkill("effects.indomitable") || _targetEntity.getSkills().hasSkill("perk.steel_brow"))
		{
			return;
		}

		local actor = this.getContainer().getActor();
		if (_targetEntity.isAlliedWith(actor) || this.m.SkillCount == ::Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
		{
			return;
		}

		this.m.SkillCount = ::Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();

		if (_targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0) < this.m.Threshold)
		{
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " is going to Cull " + ::Const.UI.getColorizedEntityName(_targetEntity));
			}
			::logDebug("[" + actor.getName() + "] is going to Cull target [" + _targetEntity.getName() + "] with skill [" + _skill.getName() + "]");
			_targetEntity.kill(actor, _skill, ::Const.FatalityType.Decapitated);
		}
	}

	function onUpdate(_properties)
	{
		if (this.getContainer().getActor().isDisarmed()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			_properties.DamageRegularMax += ::Math.floor(weapon.m.RegularDamageMax * 0.1);
		}
	}
});
