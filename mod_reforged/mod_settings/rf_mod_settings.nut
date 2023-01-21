local generalPage = ::Reforged.Mod.ModSettings.addPage("General");
local legendaryDifficulty = generalPage.addBooleanSetting("LegendaryDifficulty", false, "Legendary Difficulty");
legendaryDifficulty.getData().NewCampaign <- true;
legendaryDifficulty.addAfterChangeCallback(function( _oldValue ) {
	::Reforged.Config.IsLegendaryDifficulty = this.getValue();
});
