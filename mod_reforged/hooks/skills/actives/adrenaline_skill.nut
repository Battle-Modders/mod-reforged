::Reforged.HooksMod.hook("scripts/skills/actives/adrenaline_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Adrenaline;
	}
});
