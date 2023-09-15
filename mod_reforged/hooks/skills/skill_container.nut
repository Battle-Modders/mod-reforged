::mods_hookNewObject("skills/skill_container", function(o) {
	o.m.AuraEffects <- [];

	local update = o.update;
	o.update = function()
	{
		if (this.m.IsUpdating) return;

		if (this.getActor().isPlacedOnMap())
		{
			foreach (skill in this.m.AuraEffects)
			{
				skill.updateCurrProvider();
			}
		}

		return update();
	}

	o.registerAuraEffect <- function( _skill )
	{
		foreach (skill in this.m.AuraEffects)
		{
			if (skill.getID() == _skill.getID()) return;
		}

		this.m.AuraEffects.push(::MSU.asWeakTableRef(_skill));
	}

	o.unregisterAuraEffect <- function( _skill )
	{
		foreach (i, skill in this.m.AuraEffects)
		{
			if (skill.getID() == _skill.getID())
			{
				this.m.AuraEffects.remove(i);
				return;
			}
		}
	}
});
