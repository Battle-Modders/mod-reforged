::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_lich", function(q) {
	q.onInit = @(__original) function()
	{
		__original();
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update();
	}
});
