this.perk_rf_bear_down <- ::inherit("scripts/skills/skill", {
	m = {
		ChanceToHitHeadModifier = 15,
		ThresholdToInflictInjuryMult = 0.66,
		RequiredWeaponType = ::Const.Items.WeaponType.Mace,
		ValidEffects = [
			"effects.stunned",
			"effects.dazed",
			"effects.rf_rattled",
			"effects.net",
			"effects.sleeping",
			"effects.staggered",
			"effects.rooted",
			"effects.web"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_bear_down";
		this.m.Name = ::Const.Strings.PerkName.RF_BearDown;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BearDown;
		this.m.Icon = "ui/perks/rf_bear_down.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isSkillValid(_skill))
			return;

		if (_targetEntity.getSkills().getSkillsByFunction((@(s) this.m.ValidEffects.find(s.getID()) != null).bindenv(this)).len() != 0)
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.m.ChanceToHitHeadModifier;
			_properties.ThresholdToInflictInjuryMult *= this.m.ThresholdToInflictInjuryMult;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.getEntity() != null && this.isSkillValid(_skill) && _targetTile.getEntity().getSkills().getSkillsByFunction((@(s) this.m.ValidEffects.find(s.getID()) != null).bindenv(this)).len() != 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
