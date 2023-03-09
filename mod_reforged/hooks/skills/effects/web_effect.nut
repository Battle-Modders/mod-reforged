::mods_hookExactClass("skills/effects/web_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];
        ::Reforged.Skills.makeTrapped(this);
		this.m.BreakFreeIcon = "skills/active_113.png";
		this.m.BreakFreeIconDisabled = "skills/active_113_sw.png";
		this.m.BreakFreeOverlay = "active_113";
		this.m.BreakAllyFreeIcon = "skills/active_158.png";
		this.m.BreakAllyFreeIconDisabled = "skills/active_158_sw.png";
		this.m.BreakAllyFreeOverlay = "status_effect_100";
		this.m.Decal = "web_destroyed";
	}
});
