::Reforged.HooksMod.hook("scripts/skills/actives/reload_bolt", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRemovedAfterBattle = false;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;	// Players expect this skill to come earlier than most other active skills because of muscle memory, so we move it forward to be immediately after the shoot skill
	}
});
