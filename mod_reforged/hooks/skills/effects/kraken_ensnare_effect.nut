::mods_hookExactClass("skills/effects/kraken_ensnare_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.SoundOnHitHitpoints = [
			"sounds/enemies/dlc2/krake_break_free_fail_01.wav",
			"sounds/enemies/dlc2/krake_break_free_fail_02.wav",
			"sounds/enemies/dlc2/krake_break_free_fail_03.wav",
			"sounds/enemies/dlc2/krake_break_free_fail_04.wav",
			"sounds/enemies/dlc2/krake_break_free_fail_05.wav"
		];
        ::Reforged.Skills.makeTrapped(this);
		this.m.BreakFreeIcon = "skills/active_148.png";
		this.m.BreakFreeIconDisabled = "skills/active_148_sw.png";
		this.m.BreakFreeOverlay = "active_148";
		this.m.BreakAllyFreeIcon = "skills/active_151.png";
		this.m.BreakAllyFreeIconDisabled = "skills/active_151_sw.png";
		this.m.BreakAllyFreeOverlay = "status_effect_96";
		this.m.Decal = ::Const.BloodDecals[::Const.BloodType.Red][::Math.rand(0, ::Const.BloodDecals[::Const.BloodType.Red].len() - 1)];
	}
});
