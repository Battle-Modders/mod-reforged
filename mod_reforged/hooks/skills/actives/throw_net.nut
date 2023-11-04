::Reforged.HooksMod.hook("scripts/skills/actives/throw_net", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.ThrowNet;
	}
});
