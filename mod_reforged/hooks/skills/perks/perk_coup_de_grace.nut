::Reforged.HooksMod.hook("scripts/skills/perks/perk_coup_de_grace", function(q) {
	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isAttack())
		{
			return;
		}

		if (_targetEntity.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury) || _targetEntity.getSkills().hasSkill("effects.sleeping") || _targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.web") || _targetEntity.getSkills().hasSkill("effects.rooted"))
		{
			_properties.DamageTotalMult *= 1.2;
		}
	}

	q.onBeforeTargetHit = @() { function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && (_targetEntity.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury) || _targetEntity.getSkills().hasSkill("effects.sleeping") || _targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.web") || _targetEntity.getSkills().hasSkill("effects.rooted")))
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}}.onBeforeTargetHit;
});
