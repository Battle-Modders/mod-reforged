::Reforged.HooksMod.hook(::DynamicPerks.Class.PerkTree, function(q) {
	q.m.ProjectedAttributesAvg <- null;

	q.setupProjectedAttributesAvg <- function()
	{
		this.m.ProjectedAttributesAvg = {};

		local actor = this.getActor();
		local talents = actor.getTalents();
		local properties = this.getActor().getBaseProperties().getClone();

		local wasUpdating = actor.getSkills().m.IsUpdating;
		actor.getSkills().m.IsUpdating = true;
		foreach (s in this.getActor().getSkills().getSkillsByFunction(@( _skill ) _skill.isType(::Const.SkillType.Trait) || _skill.isType(::Const.SkillType.PermanentInjury)))
		{
			s.onUpdate(properties);
		}
		actor.getSkills().m.IsUpdating = wasUpdating;

		foreach (attributeName, attribute in ::Const.Attributes)
		{
			if (attribute == ::Const.Attributes.COUNT)
				continue;

			local attributeMin = ::Const.AttributesLevelUp[attribute].Min;
			local attributeMax = ::Const.AttributesLevelUp[attribute].Max;
			if (talents.len() != 0)
			{
				attributeMin += ::Math.min(talents[attribute], 2);
				attributeMax += talents[attribute] == 3 ? 1 : 0;
			}

			local attributeAvg = (attributeMin + attributeMax) * 0.5;

			properties[attributeName == "Fatigue" ? "Stamina" : attributeName] += ::Math.round(attributeAvg * ::Math.max(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + actor.getLevelUps(), 0));

			local value;
			switch (attributeName)
			{
				// Fatigue and Hitpoints getter functions are in actor and they use CurrentProperties
				// so we temporarily switcheroo the CurrentProperties to get our desired values
				case "Fatigue":
				case "Hitpoints":
					local originalCurrentProperties = actor.getCurrentProperties();
					actor.m.CurrentProperties = properties;
					value = actor["get" + attributeName + "Max"]();
					actor.m.CurrentProperties = originalCurrentProperties;
					break;

				default:
					value = properties["get" + attributeName]();
			}

			this.m.ProjectedAttributesAvg[attribute] <- value;
		}
	}

	q.buildFromDynamicMap = @(__original) function()
	{
		if (!::MSU.isNull(this.getActor()))
		{
			this.setupProjectedAttributesAvg();
		}
		__original();
		this.m.ProjectedAttributesAvg = null;
	}

	q.getProjectedAttributesAvg <- function()
	{
		return this.m.ProjectedAttributesAvg;
	}

	q.addItemMultipliers = @(__original) function( _multipliers )
	{
		__original(_multipliers);

		// Only if you have many weapon perk groups then we guarantee that you roll the perk group of the weapon you come equipped with
		if (this.getActor().getBackground().getPerkGroupCollectionMin(::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon")) <= 3)
			return;

		local weapon = this.getActor().getMainhandItem();
		if (!::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon))
		{
			local ids = ::Reforged.getWeaponPerkGroups(weapon);
			switch (ids.len())
			{
				case 0:
					break;

				case 1:
					_multipliers[ids[0]] <- -1;
					break;

				default:
					_multipliers[::MSU.Array.rand(ids)] <- -1;
			}
		}
	}
});
