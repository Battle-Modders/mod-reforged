this.perk_rf_mauler <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Cleaver,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		Chance = 33,
		BleedStacksRequired = 3,

		__HitInfo = null
	},
	function create()
	{
		this.m.ID = "perk.rf_mauler";
		this.m.Name = ::Const.Strings.PerkName.RF_Mauler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Mauler;
		this.m.Icon = "ui/perks/perk_rf_mauler.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!_targetEntity.getCurrentProperties().IsAffectedByInjuries || ::Math.rand(1, 100) > this.m.Chance)
			return;

		local bleeding = _targetEntity.getSkills().getAllSkillByID("effects.bleeding");
		local count = bleeding.len() == 1 ? bleeding.m.Stacks : bleeding.len();

		if (count >= this.m.BleedStacksRequired)
		{
			this.m.__HitInfo = _hitInfo;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !this.isSkillValid(_skill))
		{
			this.m.__HitInfo = null;
			return;
		}

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
		{
			this.m.__HitInfo = null;
			return;
		}

		if (_damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));

		if (this.m.__HitInfo == null || (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.crippling_strikes")))
		{
			this.m.__HitInfo = null;
			return;
		}

		_targetEntity.MV_applyInjury(_skill, this.m.__HitInfo);
		this.m.__HitInfo = null;
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill))
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts additional [Bleeding|Skill+bleeding_effect] due to " + ::Reforged.NestedTooltips.getNestedPerkName(this))
			});
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (!this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return ::MSU.isKindOf(weapon, "weapon") && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
