::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_throw_net", function (q) {
	q.m.PossibleSkills.push("actives.rf_schrat_small_root");

	q.onEvaluate = @(__original) function( _entity )
	{
		local ret = __original(_entity);
		// It is a generator in vanilla, but we add the typeof check for maximum
		// compatibility if another mod changed the original function to not be a generator.
		if (typeof ret == "generator")
		{
			local thread = ret;
			do
			{
				ret = resume thread;
			}
			while (ret == null);
		}

		if (this.m.Skill != null && ret != ::Const.AI.Behavior.Score.Zero && ::Math.rand(1, 100) < 75 && _entity.getSkills().hasSkill("perk.rf_kingfisher"))
			ret = ::Const.AI.Behavior.Score.Zero;

		return ret;
	}
});
