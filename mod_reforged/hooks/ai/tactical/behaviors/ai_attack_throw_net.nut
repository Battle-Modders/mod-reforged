::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_throw_net", function (q) {
	q.m.PossibleSkills.push("actives.rf_schrat_small_root");

	q.onEvaluate = @(__original) { function onEvaluate( _entity )
	{
		// Wrap generator properly
		local ret, gen = __original(_entity);
		while ((ret = resume gen) == null) yield null;

		if (this.m.Skill != null && ret != ::Const.AI.Behavior.Score.Zero && ::Math.rand(1, 100) < 75 && _entity.getSkills().hasSkill("perk.rf_kingfisher"))
			ret = ::Const.AI.Behavior.Score.Zero;

		return ret;
	}}.onEvaluate;
});
