::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_crossbow", function(q) {
	q.onAfterUpdate <- function( _properties )
	{
		local reload = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reload != null && reload.m.ActionPointCost > 4 && reload.getBaseValue("ActionPointCost") > 4)
			reload.m.ActionPointCost -= 1;
	}
});
