this.perk_rf_decanus <- ::inherit("scripts/skills/perks/perk_aura_abstract", {
	m = {},
	function create()
	{
		this.perk_aura_abstract.create();
		this.m.ID = "perk.rf_decanus";
		this.m.Name = ::Const.Strings.PerkName.RF_Decanus;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Decanus;
		this.m.Icon = "ui/perks/rf_decanus.png";
		this.m.AuraEffectScript = "scripts/skills/effects/rf_decanus_command_effect";
		this.m.AuraEffectID = "effects.rf_decanus_command";
		this.m.AuraRange = 4;
	}

	function validateAuraReceiver( _entity )
	{
		return _entity.isAlliedWith(this.getContainer().getActor()) && _entity.getFlags().has("skeleton");
	}
});
