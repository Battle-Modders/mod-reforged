::Reforged.HooksMod.hook("scripts/skills/perks/perk_battle_flow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_rf_battle_flow.png"
	}
});
