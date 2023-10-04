::Reforged.HooksMod.hook("scripts/skills/perks/perk_pathfinder", function(q) {
	q.onAdded <- function()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_sprint_skill"));
	}

	q.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.rf_sprint");
	}
});
