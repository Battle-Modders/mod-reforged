::mods_hookNewObject("skills/skill_container", function(o) {
	o.m.AuraEffects <- [];
	o.m.AuraPerks <- [];

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

	o.registerAuraPerk <- function( _skill )
	{
		foreach (skill in this.m.AuraPerks)
		{
			if (skill.getID() == _skill.getID()) return;
		}

		this.m.AuraPerks.push(::MSU.asWeakTableRef(_skill));
	}

	o.unregisterAuraPerk <- function( _skill )
	{
		foreach (i, skill in this.m.AuraPerks)
		{
			if (skill.getID() == _skill.getID())
			{
				this.m.AuraPerks.remove(i);
				return;
			}
		}
	}

	local onMovementFinished = o.onMovementFinished;
	o.onMovementFinished = function( _tile )
	{
		local ret = onMovementFinished(_tile);

		if (this.m.AuraPerks.len() != 0)
		{
			local actor = this.getActor();
			foreach (faction in ::Tactical.Entities.getAllInstances())
			{
				foreach (receiver in faction)
				{
					if (receiver.getID() == actor.getID()) continue;

					foreach (auraPerk in this.m.AuraPerks)
					{
						if (this.validateAuraReceiver(receiver))
						{
							receiver.getSkills().update();
							break;
						}
					}
				}
			}
		}

		return ret;
	}
});
