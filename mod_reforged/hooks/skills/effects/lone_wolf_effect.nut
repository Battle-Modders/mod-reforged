::Reforged.HooksMod.hook("scripts/skills/effects/lone_wolf_effect", function(q) {
	q.m.BonusMult <- 1.15; // Is applied to various attributes when in a valid position

	q.isHidden = @() { function isHidden()
	{
		return !this.isInValidPosition();
	}}.isHidden;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BonusMult) + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BonusMult) + " [Ranged Skill|Concept.RangeSkill]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BonusMult) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BonusMult) + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BonusMult) + " [Resolve|Concept.Bravery]")
			}
		]);
		return ret;
	}}.getTooltip;

	q.onUpdate = @() { function onUpdate( _properties )
	{
		if (this.isInValidPosition())
		{
			_properties.MeleeSkillMult *= this.m.BonusMult;
			_properties.RangedSkillMult *= this.m.BonusMult;
			_properties.MeleeDefenseMult *= this.m.BonusMult;
			_properties.RangedDefenseMult *= this.m.BonusMult;
			_properties.BraveryMult *= this.m.BonusMult;
		}
	}}.onUpdate;

// New functions
	q.isInValidPosition <- { function isInValidPosition()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return false;

		local myTile = actor.getTile();

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
	}}.isInValidPosition;
});
