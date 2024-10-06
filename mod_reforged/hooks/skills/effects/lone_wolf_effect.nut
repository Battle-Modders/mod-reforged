::Reforged.HooksMod.hook("scripts/skills/effects/lone_wolf_effect", function(q) {
	q.m.BonusMult <- 1.15; // Is applied to various attributes when in a valid position

	q.isHidden = @() function()
	{
		return this.isInValidPosition();
	}

	q.onUpdate = @() function( _properties )
	{
		if (this.isInValidPosition())
		{
			_properties.MeleeSkillMult *= this.m.BonusMult;
			_properties.RangedSkillMult *= this.m.BonusMult;
			_properties.MeleeDefenseMult *= this.m.BonusMult;
			_properties.RangedDefenseMult *= this.m.BonusMult;
			_properties.BraveryMult *= this.m.BonusMult;
		}
	}

// New functions
	q.isInValidPosition <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return false;

		local numAlliesWithinTwoTiles = 0;

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()))
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			switch (ally.getTile().getDistanceTo(myTile))
			{
				case 1:
					return false;

				case 2:
					numAlliesWithinTwoTiles++;
					break;
			}
		}

		return numAlliesWithinTwoTiles <= 1;
	}
});
