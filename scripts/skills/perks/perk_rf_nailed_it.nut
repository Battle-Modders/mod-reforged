this.perk_rf_nailed_it <- this.inherit("scripts/skills/skill", {
	m = {
		HeadShotBonus = 20,
		CloseDamageBonus = 0.25,
		BlockedChanceMult = 0.5
	},

	function create()
	{
		this.m.ID = "perk.rf_nailed_it";
		this.m.Name = this.Const.Strings.PerkName.RF_NailedIt;
		this.m.Description = this.Const.Strings.PerkDescription.RF_NailedIt;
		this.m.Icon = "ui/perks/rf_nailed_it.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || _targetEntity == null)
		{
			return;
		}

		local distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		if (distance <= 2)
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.m.HeadShotBonus;
		}

		if (distance <= 3)
		{
			_properties.DamageTotalMult	*= 1.0 + this.m.CloseDamageBonus;
			_properties.RangedAttackBlockedChanceMult *= this.m.BlockedChanceMult;
		}
	}
});
