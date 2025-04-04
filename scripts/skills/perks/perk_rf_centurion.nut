this.perk_rf_centurion <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_centurion";
		this.m.Name = ::Const.Strings.PerkName.RF_Centurion;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Centurion;
		this.m.Icon = "ui/perks/perk_rf_centurion.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 2.0;
	}

	function updateAllies()
	{
		foreach (ally in ::Tactical.Entities.getAlliedActors(this.getContainer().getActor().getFaction()))
		{
			ally.getSkills().update();
		}
	}

	function onMovementFinished()
	{
		this.updateAllies();
	}

	function onDeath( _fatalityType )
	{
		this.updateAllies();
	}
});
