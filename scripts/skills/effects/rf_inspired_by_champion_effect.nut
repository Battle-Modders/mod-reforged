this.rf_inspired_by_champion_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Difference = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_inspired_by_champion";
		this.m.Name = "Inspired by nearby Champion";
		this.m.Description = "With a champion nearby, this character has temporarily increased Resolve.";
		this.m.Icon = "ui/perks/perk_26.png";
		this.m.IconMini = "perk_26_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Difference + "[/color] Resolve"
		});

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getMoraleState() == ::Const.MoraleState.Ignore)
		{
			return 0;
		}

		local myTile = actor.getTile();
		local allies = ::Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local bestBravery = 0;

		foreach (ally in allies)
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap() || ally.getTile().getDistanceTo(myTile) > 4 || this.getContainer().getActor().getBravery() >= ally.getBravery())
			{
				continue;
			}

			if (ally.getSkills().hasSkill("racial.champion") && ally.getBravery() > bestBravery)
			{
				bestBravery = ally.getBravery();
			}
		}

		if (bestBravery != 0)
		{
			bestBravery = ::Math.min(bestBravery * 0.15, bestBravery - this.getContainer().getActor().getBravery());
		}

		return bestBravery;
	}

	function onAfterUpdate( _properties )
	{
		local bonus = this.getBonus();

		if (bonus != 0)
		{
			this.m.IsHidden = false;
			_properties.Bravery += bonus;
			this.m.Difference = bonus;
		}
		else
		{
			this.m.IsHidden = true;
			this.m.Difference = 0;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
		this.m.Difference = 0;
	}
});
