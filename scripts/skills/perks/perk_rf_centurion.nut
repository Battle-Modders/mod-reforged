this.perk_rf_centurion <- ::inherit("scripts/skills/perks/perk_aura_abstract", {
	m = {},
	function create()
	{
		this.perk_aura_abstract.create();
		this.m.ID = "perk.rf_centurion";
		this.m.Name = ::Const.Strings.PerkName.RF_Centurion;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Centurion;
		this.m.Icon = "ui/perks/rf_centurion.png";
		this.m.AuraEffectScript = "scripts/skills/effects/rf_centurion_command_effect";
		this.m.AuraEffectID = "effects.rf_centurion_command";
		this.m.AuraRange = 4;
	}

	function validateAuraReceiver( _entity )
	{
		return _entity.isAlliedWith(this.getContainer().getActor()) && _entity.getFlags().has("skeleton");
	}
});
