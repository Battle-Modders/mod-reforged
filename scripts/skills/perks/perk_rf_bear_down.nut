this.perk_rf_bear_down <- ::inherit("scripts/skills/skill", {
	m = {
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
		if (_targetEntity != null && _targetEntity.getSkills().getSkillsByFunction((@(s) this.m.ValidEffects.find(s.getID()) != null).bindenv(this)).len() != 0)
		{
			_properties.MeleeSkill += 10;
			_properties.HitChance[::Const.BodyPart.Head] += 20;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.getEntity() != null && _targetEntity.getSkills().getSkillsByFunction((@(s) this.m.ValidEffects.find(s.getID()) != null).bindenv(this)).len() != 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}
});
