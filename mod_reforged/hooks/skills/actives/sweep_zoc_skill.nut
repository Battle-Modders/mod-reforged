::Reforged.HooksMod.hook("scripts/skills/actives/sweep_zoc_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.RF_HideInTooltip = true;
	}
});
