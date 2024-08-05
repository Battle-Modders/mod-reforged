::Reforged.HooksMod.hook("scripts/skills/perks/perk_rally_the_troops", function(q) {
	q.m.Cooldown <- 0;

	q.onAdded = @() function()
	{
		this.m.Container.add(::Reforged.new("scripts/skills/actives/rally_the_troops", function(o) {
			o.m.Cooldown = this.m.Cooldown;
		}.bindenv(this)));
	}
});
