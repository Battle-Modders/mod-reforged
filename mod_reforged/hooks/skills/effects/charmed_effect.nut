::Reforged.HooksMod.hook("scripts/skills/effects/charmed_effect", function(q) {
    q.m.WasBeckoned <- false;
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
        // forward original info stored in beckoned and remove it
        local actor = this.getContainer().getActor();
        if (this.m.WasBeckoned)
        {
            this.addTurns(1)
        }
        this.m.Master.getContainer().getActor().setCharming(true);
	}}.onAdded;
});
