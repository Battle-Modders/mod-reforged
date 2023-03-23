::mods_hookExactClass("skills/perks/perk_dodge", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function()
	{
		onAdded();
		this.getContainer().add(::new("scripts/skills/actives/rf_sprint_skill"));
	}

	local onRemoved = o.onRemoved;
	o.onRemoved <- function()
	{
		onRemoved();
		this.getContainer().removeByID("actives.rf_sprint");
	}
});
