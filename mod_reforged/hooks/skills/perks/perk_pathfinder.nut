::mods_hookExactClass("skills/perks/perk_pathfinder", function (o) {
	o.onAdded <- function()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_sprint_skill"));
	}

	o.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.rf_sprint");
	}
});
