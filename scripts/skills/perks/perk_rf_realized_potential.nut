this.perk_rf_realized_potential <- ::inherit("scripts/skills/skill", {
	m = {
		AttributeModifier = 15,
		DailyWageMult = 2.0,
		NewPerkGroups = {
			"pgc.rf_shared_1": 1, // categoryID : numGroups from this category
			"pgc.rf_weapon": 2
		},
		ExcludedPerkGroups = [
			"pg.rf_tactician"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_realized_potential";
		this.m.Name = ::Const.Strings.PerkName.RF_RealizedPotential;
		this.m.Description = ::Const.Strings.PerkDescription.RF_RealizedPotential;
		this.m.Icon = "ui/perks/perk_rf_realized_potential.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			local actor = this.getContainer().getActor();

			actor.resetPerks();
			actor.m.PerkPoints++;

			// Adjust Wage and Attributes
			local b = actor.getBaseProperties();
			b.DailyWageMult *= this.m.DailyWageMult;
			b.MeleeSkill += this.m.AttributeModifier;
			b.MeleeDefense += this.m.AttributeModifier;
			b.RangedSkill += this.m.AttributeModifier;
			b.RangedDefense += this.m.AttributeModifier;
			b.Hitpoints += this.m.AttributeModifier;
			b.Stamina += this.m.AttributeModifier;
			b.Initiative += this.m.AttributeModifier;
			b.Bravery += this.m.AttributeModifier;

			// Add new Perk Groups
			local perkTree = actor.getPerkTree();
			local exclude = clone this.m.ExcludedPerkGroups;

			foreach (categoryID, numGroups in this.m.NewPerkGroups)
			{
				local category = ::DynamicPerks.PerkGroupCategories.findById(categoryID);
				foreach (groupID in category.getGroups())
				{
					if (perkTree.hasPerkGroup(groupID))
						exclude.push(groupID);
				}

				for (local i = 0; i < numGroups; i++)
				{
					local newPerkGroup = category.getRandomGroup(exclude);
					if (newPerkGroup != null)
					{
						perkTree.addPerkGroup(newPerkGroup);
						exclude.push(newPerkGroup);
					}
				}
			}

			// Adjust bro's perk tree so that no row is longer than 13 perks (so that it fits in the UI properly)
			foreach (i, row in perkTree.getTree())
			{
				if (row.len() <= 13)
					continue;

				for (local i = row.len() - 1; i > 12; i--)
				{
					local id = row[i].ID;
					local tier = i + 1;
					perkTree.removePerk(id);
					if (tier != 7) perkTree.addPerk(id, tier + 1);
				}
			}
		}
	}
});
