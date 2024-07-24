this.rf_faction_banner_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_faction_banner";
		this.m.Name = "For the realm!";
		this.m.Description = "With their noble house\'s glorious battle standard nearby, this character feels compelled to push onward and spit danger in the face.";
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("Receive no [morale check|Concept.Morale] from dying allies as long as a faction member carries your banner and your faction outnumbers your enemies")
		});
		
		return ret;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = true;
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local numEnemies = 0;
		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			if (faction == actor.getFaction())
				continue;

			foreach (entity in faction)
			{
				if (!entity.isAlliedWith(actor))
				{
					numEnemies += faction.len();
					break;
				}
			}
		}

		local allies = ::Tactical.Entities.getInstancesOfFaction(actor.getFaction());

		if (numEnemies >= allies.len())
			return;

		local myTile = actor.getTile();
		foreach (ally in allies)
		{
			if (!ally.isPlacedOnMap())
				continue;

			local mainhand = ally.getMainhandItem();
			if (mainhand != null && mainhand.getID() == "weapon.faction_banner")
			{
				_properties.IsAffectedByDyingAllies = false;
				this.m.IsHidden = false;
				return;
			}
		}
	}
});

