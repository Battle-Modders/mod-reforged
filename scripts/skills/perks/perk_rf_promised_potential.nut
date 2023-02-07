this.perk_rf_promised_potential <- ::inherit("scripts/skills/skill", {
	m = {
		StatBoost = 15,
		WillSucceed = false
	},
	function create()
	{
		this.m.ID = "perk.rf_promised_potential";
		this.m.Name = ::Const.Strings.PerkName.RF_PromisedPotential;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PromisedPotential;
		this.m.Icon = "ui/perks/rf_promised_potential.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRefundable = false;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			this.m.WillSucceed = ::Math.rand(1, 100) <= 50 - (this.getContainer().getActor().getPerkPointsSpent() * 10);
		}
	}

	function onUpdateLevel()
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Level == 11 || (actor.m.Level == 7 && ::World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave"))
		{
			this.removeSelf();

			local perkTree = actor.getBackground().getPerkTree();
			perkTree.removePerk(this.getID());

			if (!this.m.WillSucceed)
			{
				perkTree.addPerk("perk.rf_failed_potential", 1);
				this.getContainer().add(::new("scripts/skills/perks/perk_rf_failed_potential"));
			}
			else
			{
				actor.m.PerkPoints++;
				actor.m.PerkPointsSpent--;
				perkTree.addPerk("perk.rf_realized_potential", 1);
				this.getContainer().add(::new("scripts/skills/perks/perk_rf_realized_potential"));

				if (this.getContainer().hasSkill("perk.rf_trauma_survivor"))
				{
					actor.m.PerkPoints++;
					actor.m.PerkPointsSpent--;
				}

				local b = actor.getBaseProperties();
				b.DailyWageMult *= 2;
				b.MeleeSkill += this.m.StatBoost;
				b.MeleeDefense += this.m.StatBoost;
				b.RangedSkill += this.m.StatBoost;
				b.RangedDefense += this.m.StatBoost;
				b.Hitpoints += this.m.StatBoost;
				b.Stamina += this.m.StatBoost;
				b.Initiative += this.m.StatBoost;
				b.Bravery += this.m.StatBoost;

				actor.getBackground().m.Description += " Once a dreg of society, with your help, " + actor.getNameOnly() + " has grown into a full-fledged mercenary.";

				local categories = [
					"pgc.rf_shared_1",
					"pgc.rf_weapon",
					"pgc.rf_weapon"
				];

				foreach (categoryID in categories)
				{
					local category = ::DynamicPerks.PerkGroupCategories.findById(categoryID);
					local exclude = ["pg.rf_talented"];
					foreach (groupID in category.getGroups())
					{
						if (perkTree.hasPerkGroup(groupID)) exclude.push(groupID);
					}
					local newPerkGroup = category.getRandomGroup(exclude);
					if (newPerkGroup != null) perkTree.addPerkGroup(newPerkGroup);
				}

				foreach (i, row in perkTree.getTree())
				{
					if (row.len() <= 13) continue;
					for (local i = row.len() - 1; i > 12; i--)
					{
						local id = row[i].ID;
						local tier = i + 1;
						perkTree.removePerk(id);
						if (tier != 7) perkTree.addPerk(id, tier + 1);
					}
				}

				actor.resetPerks();

				actor.improveMood(1.0, "Realized potential");
			}
		}
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeBool(this.m.WillSucceed);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.WillSucceed = _in.readBool();
	}
});
