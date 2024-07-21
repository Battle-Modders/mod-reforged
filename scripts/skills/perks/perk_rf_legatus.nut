this.perk_rf_legatus <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_legatus";
		this.m.Name = ::Const.Strings.PerkName.RF_Legatus;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Legatus;
		this.m.Icon = "ui/perks/perk_rf_legatus.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 2.5;
	}

	function updateAllies()
	{
		foreach (ally in ::Tactical.Entities.getAlliedActors(this.getContainer().getActor().getFaction()))
		{
			ally.getSkills().update();
		}
	}

	function onMovementFinished( _tile )
	{
		this.updateAllies();
	}

	function onDeath( _fatalityType )
	{
		this.updateAllies();
	}
});
