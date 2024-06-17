::Reforged.HooksMod.hook("scripts/skills/actives/tail_slam_zoc_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.RF_HideInTooltip = true;
	}
});
