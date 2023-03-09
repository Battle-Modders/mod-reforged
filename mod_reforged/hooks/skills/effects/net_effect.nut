::mods_hookExactClass("skills/effects/net_effect", function(o) {
	o.m.DebuffPerStage <- 0.25;		// At 2 Stages this is 44,75% which is basically equal to the vanilla value. But at 1 Stage it is only 25%

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
		this.m.BreakFreeIcon = "skills/active_74.png";
		this.m.BreakFreeIconDisabled = "skills/active_74_sw.png";
		this.m.BreakFreeOverlay = "active_74";
		this.m.BreakAllyFreeIcon = "skills/active_157.png";
		this.m.BreakAllyFreeIconDisabled = "skills/active_157_sw.png";
		this.m.BreakAllyFreeOverlay = "status_effect_99";
		this.m.Decal = "net_destroyed";		// In vanilla this is different for reinforced nets. They have "net_destroyed_02" here. This is a TODO

		this.m.Stage = 2;
		this.m.StageMax = 2;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
		foreach (entry in ret)
		{
			entry.text = ::MSU.String.replace(entry.text, "-45", "" + ::Math.floor(this.getDebuffMultiplier() * 100.0 - 100.0));
		}
		return ret;
	}

	o.getName <- function()
	{
		return this.skill.getName() + " (" + this.m.Stage + ")";
	}

	// Complete overwrite of vanilla as we change all aspects of it. IsRooted is also now handled by the trap-effect
	o.onUpdate = function( _properties )
	{
		local debuffMultiplier = this.getDebuffMultiplier();
		_properties.MeleeDefenseMult *= debuffMultiplier;
		_properties.RangedDefenseMult *= debuffMultiplier;
		_properties.InitiativeMult *= debuffMultiplier;
	}

	// New Functions
	o.getDebuffMultiplier <- function()
	{
		return ::Math.pow(1.0 - this.m.DebuffPerStage, this.m.Stage);
	}
});
