this.perk_rf_promised_potential <- ::inherit("scripts/skills/skill", {
	m = {
		Chance = 50
	},
	function create()
	{
		this.m.ID = "perk.rf_promised_potential";
		this.m.Name = ::Const.Strings.PerkName.RF_PromisedPotential;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PromisedPotential;
		this.m.Icon = "ui/perks/perk_rf_promised_potential.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}

	function onUpdateLevel()
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Level == 11 || (actor.m.Level == 7 && ::World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getContainer().getActor().getBackground().getID() == "background.slave"))
		{
			this.removeSelf();

			local perkTree = actor.getPerkTree();
			perkTree.removePerk(this.getID());

			if (this.willSucceed())
			{
				perkTree.addPerk("perk.rf_realized_potential", 1);
				this.getContainer().add(::new("scripts/skills/perks/perk_rf_realized_potential"));
				actor.improveMood(1.0, "Realized potential");
				actor.getBackground().m.Description += " Once a dreg of society, with your help, " + actor.getNameOnly() + " has grown into a full-fledged mercenary.";
			}
			else
			{
				perkTree.addPerk("perk.rf_failed_potential", 1);
				this.getContainer().add(::new("scripts/skills/perks/perk_rf_failed_potential"));
			}
		}
	}

	function willSucceed()
	{
		return this.getContainer().hasSkill("trait.player") || ::Reforged.Math.seededRand(1, 100, this.getContainer().getActor().getUID(), this.getID()) <= this.m.Chance;
	}
});
