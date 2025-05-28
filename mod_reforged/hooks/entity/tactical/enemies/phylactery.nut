::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/phylactery", function(q) {
	q.onInit = @(__original) { function onInit()
	{
		__original();
		this.m.BaseProperties.IsAffectedByReach = false;
		this.m.Skills.update();
	}}.onInit;
});
