::Reforged.HooksMod.hook("scripts/skills/actives/puncture", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Puncture;
	}
});
