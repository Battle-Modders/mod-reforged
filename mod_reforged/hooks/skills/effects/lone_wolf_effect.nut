::Reforged.HooksMod.hook("scripts/skills/effects/lone_wolf_effect", function(q) {
	// The vanilla function but change distance to <=2 tiles instead of <=3
	q.onUpdate = @(__original) function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isAlone = true;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 2)
			{
				isAlone = false;
				break;
			}
		}

		if (isAlone)
		{
			this.m.IsHidden = false;
			_properties.MeleeSkillMult *= 1.15;
			_properties.RangedSkillMult *= 1.15;
			_properties.MeleeDefenseMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
			_properties.BraveryMult *= 1.15;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}
});
