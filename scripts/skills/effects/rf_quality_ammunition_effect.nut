this.rf_quality_ammunition_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ArmorPiercingMult = 1.2,
		ArmorDamageMult = 1.2,
	},

	function create()
	{
		this.m.ID = "effects.rf_quality_ammunition";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.First;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;		// In its first iteration this effect is very simple and doesn't need its own visible effect for the player to understand where this is coming from
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() == false) return;
		if (_skill.isRanged() == false) return;
		if (_skill.getItem() != this.getItem()) return;		// The skill used belongs to a different weapon than our ammunition is currently loaded in

		// By design we don't need to check whether the right ammo is loaded. Because otherwise this effect would not exist on this character

        _properties.DamageArmorMult *= this.m.ArmorDamageMult;
		_properties.DamageDirectMult *= this.m.ArmorPiercingMult;
	}

});
