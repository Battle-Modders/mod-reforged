::Reforged.HooksMod.hook("scripts/skills/actives/riposte", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Riposte;
	}
});
