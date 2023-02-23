::mods_hookExactClass("ai/tactical/behaviors/ai_defend_riposte", function (o) {
	o.m.PossibleSkills.push("actives.rf_bearded_blade");

	local onEvaluate = o.onEvaluate;
	o.onEvaluate = function( _entity )
	{
		local score = onEvaluate(_entity);
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
