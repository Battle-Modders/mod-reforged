::mods_hookExactClass("skills/perks/perk_rally_the_troops", function(o) {
	o.m.Cooldown <- 0;

	o.onAdded = function()
	{
		this.m.Container.add(::new("scripts/skills/actives/rally_the_troops", function(o) {
			o.m.Cooldown = this.m.Cooldown;
		}.bindenv(this)));
	}
});
