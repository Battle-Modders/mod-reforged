::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_lich_mirror_image", function(q) {
	q.onInit = @(__original) { function onInit()
	{
		__original();
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update();
	}}.onInit;
});
