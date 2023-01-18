::mods_hookExactClass("skills/actives/fire_handgonne_skill", function(o) {
	// Overwrite vanilla function to set IsHidden of reload_handgonne_skill to false instead of adding the skill
	// Necessary for custom skill costs for each weapon and for showing weapon skills in tooltip
	o.onUse = function( _user, _targetTile	)
	{
		::Sound.play(this.m.SoundOnFire[this.Math.rand(0, this.m.SoundOnFire.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, _user.getPos());
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		::Time.scheduleEvent(::TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		this.getItem().setLoaded(false);
		local reload = this.getContainer().getSkillByID("actives.reload_handgonne");
		if (reload != null)
		{
			reload.m.IsHidden = false;
		}

		return true;
	}

	// Overwrite the vanilla function to prevent removal of reload_bolt
	o.onRemoved = function()
	{
	}
});
