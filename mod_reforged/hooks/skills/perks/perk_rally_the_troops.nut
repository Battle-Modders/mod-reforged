::Reforged.HooksMod.hook("scripts/skills/perks/perk_rally_the_troops", function(q) {
	q.m.Cooldown <- 0;

	q.onAdded = @(__original) function()
	{
		this.m.Container.add(::MSU.new("scripts/skills/actives/rally_the_troops", function(o) {
			o.m.Cooldown = this.m.Cooldown;
		}.bindenv(this)));
	}
});
