local tacticalTooltipPage = ::Reforged.Mod.ModSettings.addPage("Tactical Tooltips");

tacticalTooltipPage.addBooleanSetting("AttributesPlayer", true, "Show Attributes for Player");
tacticalTooltipPage.addBooleanSetting("AttributesNonPlayer", true, "Show Attributes for Non-Player");
tacticalTooltipPage.addBooleanSetting("EffectsPlayer", true, "Show Effects for Player");
tacticalTooltipPage.addBooleanSetting("EffectsNonPlayer", true, "Show Effects for Non-Player");
tacticalTooltipPage.addBooleanSetting("PerksPlayer", true, "Show Perks for Player");
tacticalTooltipPage.addBooleanSetting("PerksNonPlayer", true, "Show Perks for Non-Player");
tacticalTooltipPage.addBooleanSetting("ItemsPlayer", true, "Show Items for Player");
tacticalTooltipPage.addBooleanSetting("ItemsNonPlayer", true, "Show Items for Non-Player");

tacticalTooltipPage.addRangeSetting("CollapseEffectsWhenX", 20, 0, 20, 1, "Collapse Effects When", "While the amount of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addRangeSetting("CollapsePerksWhenX", 7, 0, 20, 1, "Collapse Perks When", "While the amount of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addBooleanSetting("HeaderForEmptyCategories", false, "Show Header for empty categories");
