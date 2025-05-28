::Reforged.HooksMod.hook("scripts/entity/tactical/human", function(q) {
	q.onInit = @(__original) { function onInit()
	{
		__original();
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
		this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));
	}}.onInit;
});
