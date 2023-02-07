local generalPage = ::Reforged.Mod.ModSettings.addPage("General");
local legendaryDifficulty = generalPage.addBooleanSetting("LegendaryDifficulty", false, "Legendary Difficulty");
legendaryDifficulty.getData().NewCampaign <- true;
legendaryDifficulty.addAfterChangeCallback(function( _oldValue ) {
	::Reforged.Config.IsLegendaryDifficulty = this.getValue();
});

local tacticalTooltipPage = ::Reforged.Mod.ModSettings.addPage("Tactical Tooltips");

tacticalTooltipPage.addBooleanSetting("AttributesPlayer", true, "Show Attributes for Player");
tacticalTooltipPage.addBooleanSetting("AttributesNonPlayer", true, "Show Attributes for Non-Player");
tacticalTooltipPage.addBooleanSetting("EffectsPlayer", true, "Show Effects for Player");
tacticalTooltipPage.addBooleanSetting("EffectsNonPlayer", true, "Show Effects for Non-Player");
tacticalTooltipPage.addBooleanSetting("PerksPlayer", true, "Show Perks for Player");
tacticalTooltipPage.addBooleanSetting("PerksNonPlayer", true, "Show Perks for Non-Player");
tacticalTooltipPage.addBooleanSetting("EquippedItemsPlayer", true, "Show equipped Items for Player", "Accessories and Items which are equipped in the main- or offhand are listed in the tactical tooltip for player characters.");
tacticalTooltipPage.addBooleanSetting("EquippedItemsNonPlayer", true, "Show equipped Items for Non-Player", "Accessories and Items which are equipped in the main- or offhand are listed in the tactical tooltip for non-player characters.");
tacticalTooltipPage.addBooleanSetting("BagItemsPlayer", true, "Show Bag-Items for Player", "Items, which are placed in the bag slots are listed in the tactical tooltip for player characters.");
tacticalTooltipPage.addBooleanSetting("BagItemsNonPlayer", true, "Show Bag-Items for Non-Player", "Items, which are placed in the bag slots are listed in the tactical tooltip for non-player characters.");

tacticalTooltipPage.addRangeSetting("CollapseEffectsWhenX", 20, 0, 20, 1, "Collapse Effects When", "While the number of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addRangeSetting("CollapsePerksWhenX", 7, 0, 20, 1, "Collapse Perks When", "While the number of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addBooleanSetting("HeaderForEmptyCategories", false, "Show Header for empty categories");
