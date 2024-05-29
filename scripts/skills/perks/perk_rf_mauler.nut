this.perk_rf_mauler <- this.inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Cleaver,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		Chance = 33,
		BleedStacksRequired = 3
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

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.InjuryPool = null;

		if (!_targetEntity.getCurrentProperties().IsAffectedByInjuries || ::Math.rand(1, 100) > this.m.Chance)
			return;

		local bleeding = _targetEntity.getSkills().getSkillByID("effects.bleeding");
		if (bleeding != null && bleeding.m.Stacks >= this.m.BleedStacksRequired)
			this.m.InjuryPool = _hitInfo.Injuries;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !this.isSkillValid(_skill))
			return;

		if (_damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));

		if (this.m.InjuryPool == null || (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.crippling_strikes")))
			return;

		this.applyInjury(_targetEntity);
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.InjuryPool = null;
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill))
		{
			_tooltip.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Inflicts additional [Bleeding|Skill+bleeding_effect] due to [%s|Perk+%s]", ::Const.Perks.findById(this.getID()).Name, split(::IO.scriptFilenameByHash(this.ClassNameHash), "/").top()))
			});
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (!this.m.RequiredWeaponType != null && !_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}

	// It is a copy of how vanilla applies injury in actor.nut onDamageReceived function
	function applyInjury( _targetEntity )
	{
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
					::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_targetEntity) + " suffers " + injury.getNameOnly() + " due to " + ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + ::Const.Perks.findById(this.getID()).Name + " perk!");
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
});
