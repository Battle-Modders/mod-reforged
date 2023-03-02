this.perk_rf_nailed_it <- this.inherit("scripts/skills/skill", {
	m = {
		BaseBonus = 25,
		BonusDecreasePerTile = 5
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
		_properties.HitChance[::Const.BodyPart.Head] += ::Math.max(0, this.m.BaseBonus - this.m.BonusDecreasePerTile * (distance - 2));

		if (distance == 2)
		{
			_properties.RangedAttackBlockedChanceMult *= 0.5;
		}
	}
});
