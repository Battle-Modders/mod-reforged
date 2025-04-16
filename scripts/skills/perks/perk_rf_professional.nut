this.perk_rf_professional <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_professional";
		this.m.Name = ::Const.Strings.PerkName.RF_Professional;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Professional;
		this.m.Icon = "ui/perks/perk_rf_professional.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		local chosenPerkGroupID;

		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("RF_ProfessionalPerkGroupID"))
		{
			chosenPerkGroupID = actor.getFlags().get("RF_ProfessionalPerkGroupID");
		}
		else
		{
			local perkGroups = [
				"pg.rf_axe",
				"pg.rf_cleaver",
				"pg.rf_flail",
				"pg.rf_hammer",
				"pg.rf_mace",
				"pg.rf_polearm",
				"pg.rf_spear",
				"pg.rf_sword"
			];

			local options = [];
			foreach (pg in perkGroups)
			{
				if (actor.getPerkTree().hasPerkGroup(pg))
				{
					options.push(pg);
				}
			}

			if (options.len() == 0)
				return;

			chosenPerkGroupID = options[::Reforged.Math.seededRand(1000 * actor.getUID() + ::toHash(this.getID()), 0, options.len() - 1)];

			actor.getFlags().set("RF_ProfessionalPerkGroupID", chosenPerkGroupID);
		}

		local perkIDs = [];
		foreach (row in ::DynamicPerks.PerkGroups.findById(chosenPerkGroupID).getTree())
		{
			foreach (perkID in row)
			{
				perkIDs.push(perkID);
			}
		}

		if (perkIDs.len() > 2)
			perkIDs = perkIDs.slice(0, 2);

		foreach (id in perkIDs)
		{
			this.getContainer().add(::Reforged.new(actor.getPerkTree().getPerk(id).Script, function(o) {
				o.m.IsSerialized = false;
				o.m.IsRefundable = false;
			}));
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		local chosenPerkGroupID = actor.getFlags().get("RF_ProfessionalPerkGroupID");
		actor.getFlags().remove("RF_ProfessionalPerkGroupID");

		local perkIDs = [];
		foreach (row in ::DynamicPerks.PerkGroups.findById(chosenPerkGroupID).getTree())
		{
			foreach (perkID in row)
			{
				perkIDs.push(perkID);
			}
		}

		if (perkIDs.len() > 2)
			perkIDs = perkIDs.slice(0, 2);

		foreach (id in perkIDs)
		{
			this.getContainer().removeByStackByID(id, false);
		}
	}
});
