::Reforged.HooksMod.hook("scripts/skills/perks/perk_hold_out", function(q) {
	q.m.PoiseMult <- 1.5;

	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/rf_battle_flow.png"
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.PoiseMult *= this.m.PoiseMult;
	}
});
