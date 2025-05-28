::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghost_knight", function(q) {
	q.onInit = @(__original) { function onInit()
	{
		__original();
		// He already has 999 ranged defense in vanilla, and in Reforged we have a reworked Anticipation
		// which doesn't fit well with this entity's design.
		this.m.Skills.removeByID("perk.anticipation");
	}}.onInit;
});
