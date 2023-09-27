::Reforged.HooksMod.hook("scripts/entity/tactical/human", function(q) {
	q.onInit = @(__original) function()
	{
		__original();
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
		this.m.BaseProperties.PoiseMax = ::Reforged.Poise.Default.Human;
		this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));
	}
});
