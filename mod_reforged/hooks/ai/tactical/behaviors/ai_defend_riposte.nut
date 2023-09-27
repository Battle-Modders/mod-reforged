::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_defend_riposte", function(q) {
	q.m.PossibleSkills.push("actives.rf_bearded_blade");

	q.onEvaluate = @(__original) function( _entity )
	{
		local score = __original(_entity);
		if (this.m.Skill != null && this.m.Skill.getID() == "actives.riposte")
		{
			// Don't use Riposte if you have the En Garde perk which can be used to trigger it for free
			local engarde = _entity.getSkills().getSkillByID("actives.rf_en_garde_toggle");
			if (engarde != null && !engarde.pickSkill() != null)
			{
				score = ::Const.AI.Behavior.Score.Zero;
			}
		}

		return score;
	}
});
