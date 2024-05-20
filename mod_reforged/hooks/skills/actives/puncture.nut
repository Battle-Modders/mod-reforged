::Reforged.HooksMod.hook("scripts/skills/actives/puncture", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Puncture;
	}

	// Revert the modification to DamageTotalMult in vanilla which they did as a compensation to revert
	// the damage bonus from Double Grip. Instead, we prevent puncture from using Double Grip directly within
	// double_grip.nut, because we have a custom implementation of double grip bonus for daggers.
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		local old_DamageTotalMult = _properties.DamageTotalMult;
		__original(_skill, _targetEntity, _properties);
		_properties.DamageTotalMult = old_DamageTotalMult;
	}
});
