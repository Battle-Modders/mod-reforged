this.perk_rf_exude_confidence <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_exude_confidence";
		this.m.Name = ::Const.Strings.PerkName.RF_ExudeConfidence;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ExudeConfidence;
		this.m.Icon = "ui/perks/rf_exude_confidence.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || actor.getMoraleState() == ::Const.MoraleState.Fleeing || actor.getMoraleState() == ::Const.MoraleState.Ignore)
		{
			return;
		}

		local allies = ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1, true);
		foreach (ally in allies)
		{
			if (ally.getMoraleState() < actor.getMoraleState())
			{
				ally.setMoraleState(::Math.min(::Const.MoraleState.Confident, ally.getMoraleState() + 1));
				this.spawnIcon("perk_rf_exude_confidence", ally.getTile());
			}
		}
	}
});
