::Reforged.HooksMod.hook("scripts/ai/tactical/behavior", function(q) {
    q.queryTargetValue = @(__original) function( _entity, _target, _skill = null )
    {
        // Currently Mortars are near invincible and not meant to be killed. But AI still targets them sometimes. This line should make it so they are basically never targeted.
        if (_entity.getType() == ::Const.EntityType.Mortar) return 0.01;
        return __original(_entity, _target, _skill);
    }
});
