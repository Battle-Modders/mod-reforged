this.perk_rf_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_ghostlike";
		this.m.Name = ::Const.Strings.PerkName.RF_Ghostlike;
		this.m.Description = "Blink and you\'ll miss me.";
		this.m.Icon = "ui/perks/rf_ghostlike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next movement will ignore [Zone of Control|Concept.ZoneOfControl]")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = true;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local numAllies = 0;
			local numEnemies = 0;
			local myTile = actor.getTile();
			foreach (faction in ::Tactical.Entities.getAllInstances())
			{
				foreach (otherActor in faction)
				{
					if (!otherActor.isPlacedOnMap() || otherActor.getTile().getDistanceTo(myTile) != 1)
						continue;

					if (otherActor.isAlliedWith(actor)) numAllies++;
					else numEnemies++;
				}
			}
			if (numAllies >= numEnemies)
			{
				_properties.IsImmuneToZoneOfControl = true;
				this.m.IsHidden = false;
			}
		}
	}
});
