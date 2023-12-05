::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_lich_mirror_image", function(q) {
	q.onInit = @(__original) function()
	{
		__original();
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update();
	}
});
