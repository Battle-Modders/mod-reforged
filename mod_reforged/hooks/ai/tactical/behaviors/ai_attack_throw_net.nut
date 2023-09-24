::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_throw_net", function (q) {
	q.onEvaluate = @(__original) function( _entity )
	{
		local ret = __original(_entity);
		if (this.m.Skill != null && ret != ::Const.AI.Behavior.Score.Zero && ::Math.rand(1, 100) < 75 && _entity.getSkills().hasSkill("perk.rf_kingfisher"))
			ret = ::Const.AI.Behavior.Score.Zero;

		return ret;
	}
});
