::Reforged.HooksMod.hook("scripts/skills/effects/charmed_effect", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
        // forward original info stored in beckoned and remove it
        local actor = this.getContainer().getActor();
        if (actor.getSkills().hasSkill("effects.rf_beckoned"))
        {
            local beckon_eff = actor.getSkills().getSkillByID("effects.rf_beckoned")
            this.m.OriginalFaction = beckon_eff.m.OriginalFaction;
            this.m.OriginalAgent = beckon_eff.m.OriginalAgent;
            this.m.OriginalSocket = beckon_eff.m.OriginalSocket;
            actor.getSkills().removeSkillByID("effects.rf_beckoned");
        }
	}}.onAdded;
});
