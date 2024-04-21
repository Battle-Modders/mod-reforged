this.rf_bone_platings_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_bone_platings";
		this.m.Name = "Bone Plating";
		this.m.Description = "Completely absorbs the next hit to the body which doesn\'t ignore armor";
		this.m.Icon = "skills/rf_bone_platings_effect.png";
		this.m.IconMini = "rf_bone_platings_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == ::Const.BodyPart.Body && _hitInfo.DamageDirect < 1.0)
		{
			_properties.DamageReceivedTotalMult = 0.0;
			::Tactical.EventLog.logEx("All damage was absorbed (" + this.getName() + ")");
			this.removeSelf();
		}
	}
});
