this.perk_rf_legatus <- ::inherit("scripts/skills/perks/perk_aura_abstract", {
	m = {},
	function create()
	{
		this.perk_aura_abstract.create();
		this.m.ID = "perk.rf_legatus";
		this.m.Name = ::Const.Strings.PerkName.RF_Legatus;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Legatus;
		this.m.Icon = "ui/perks/rf_legatus.png";
		this.m.AuraEffectScript = "scripts/skills/effects/rf_legatus_command_effect";
		this.m.AuraEffectID = "effects.rf_legatus_command";
		this.m.AuraRange = 4;
	}

	function validateAuraReceiver( _entity )
	{
		return _entity.isAlliedWith(this.getContainer().getActor()) && _entity.getFlags().has("skeleton");
	}
});
