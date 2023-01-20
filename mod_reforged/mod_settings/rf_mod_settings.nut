local generalPage = ::Reforged.Mod.ModSettings.addPage("General");
local legendaryDifficulty = generalPage.addBooleanSetting("LegendaryDifficulty", false, "Legendary Difficulty");
legendaryDifficulty.getData().NewCampaign <- true;
legendaryDifficulty.onBeforeChangeCallback(function( _newValue ) {
	::Reforged.Config.IsLegendaryDifficulty = _newValue;
});
