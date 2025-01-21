this.perk_rf_through_the_gaps <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		RequiredWeaponType = ::Const.Items.WeaponType.Spear,
		DirectDamageModifierMin = 0.10,
		DirectDamageModifierMax = 0.25
	},
	function create()
	{
		this.m.ID = "perk.rf_through_the_gaps";
		this.m.Name = ::Const.Strings.PerkName.RF_ThroughTheGaps;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ThroughTheGaps;
		this.m.Icon = "ui/perks/perk_rf_through_the_gaps.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpent || !this.isSkillValid(_skill))
			return;

		_properties.DirectDamageAdd += _targetEntity == null ? this.m.DirectDamageModifierMax : ::MSU.Math.randf(this.m.DirectDamageModifierMin, this.m.DirectDamageModifierMax);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.IsSpent = true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
