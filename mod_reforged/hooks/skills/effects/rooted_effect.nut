::mods_hookExactClass("skills/effects/rooted_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
		];
        ::Reforged.Skills.makeTrapped(this);
		this.m.BreakFreeIcon = "skills/active_75.png";
		this.m.BreakFreeIconDisabled = "skills/active_75_sw.png";
		this.m.BreakFreeOverlay = "active_75";
		this.m.BreakAllyFreeIcon = "skills/active_159.png";
		this.m.BreakAllyFreeIconDisabled = "skills/active_159_sw.png";
		this.m.BreakAllyFreeOverlay = "status_effect_101";
		this.m.Decal = "roots_destroyed";
	}
});
