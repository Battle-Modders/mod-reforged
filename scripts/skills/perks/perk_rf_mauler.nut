this.perk_rf_mauler <- this.inherit("scripts/skills/skill", {
	m = {
		Chance = 33,
		InjuryPool = null
	},

	function create()
	{
		this.m.ID = "perk.rf_mauler";
		this.m.Name = ::Const.Strings.PerkName.RF_Mauler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Mauler;
		this.m.Icon = "ui/perks/rf_mauler.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Cleaver);
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.InjuryPool = null;

		if (::Math.rand(1, 100) <= this.m.Chance && _targetEntity.getCurrentProperties().IsAffectedByInjuries && _targetEntity.getSkills().getSkillByID("effects.bleeding").m.Stacks >= 3)
			this.m.InjuryPool = _hitInfo.Injuries;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !_skill.isAttack() || !this.isEnabled())
			return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));

		if (this.m.InjuryPool == null || (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.crippling_strikes")))
			return;

		// Below is a copy of how vanilla applies injury in actor.nut onDamageReceived function
		local potentialInjuries = [];

		foreach( inj in this.m.InjuryPool )
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
					::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_targetEntity) + " suffers " + injury.getNameOnly() + " due to " + ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s Mauler perk!");
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

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.InjuryPool = null;
	}
});
