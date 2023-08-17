this.rf_shrapnell_bullets_ammo_effect <- this.inherit("scripts/skills/skill", {
	m = {
		// Public
        DamageMultiplier = 0.9,
        ArmorPiercingMult = 0.9,
        HitChanceModifier = 35
	},

	function create()
	{
		this.m.ID = "effects.rf_shrapnell_bullets_ammo";
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

		_properties.RangedDamageMult *= this.m.DamageMultiplier;
		_properties.DamageDirectMult *= this.m.ArmorPiercingMult;
        _properties.RangedSkill += this.m.HitChanceModifier;	// TODO: Implement this as an actual hitchance bonus? Otherwise this is getting scaled by RangedSkill multipliers
	}

});
