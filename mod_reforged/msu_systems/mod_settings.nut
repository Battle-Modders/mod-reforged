local generalPage = ::Reforged.Mod.ModSettings.addPage("General");
local legendaryDifficulty = generalPage.addBooleanSetting("LegendaryDifficulty", false, "Legendary Difficulty");
legendaryDifficulty.getData().NewCampaign <- true;
legendaryDifficulty.addAfterChangeCallback(function( _oldValue ) {
	::Reforged.Config.IsLegendaryDifficulty = this.getValue();
});

local tacticalTooltipPage = ::Reforged.Mod.ModSettings.addPage("Tactical Tooltips");

tacticalTooltipPage.addEnumSetting("TacticalTooltip_Attributes", "All", ["All", "AI Only", "Player Only", "None"], "Show Attributes", "Show attributes such as Melee Skill, Melee Defense etc. for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_Effects", "All", ["All", "AI Only", "Player Only", "None"], "Show Effects", "Show status effects for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_Perks", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show perks for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_EquippedItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show equipped items for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_BagItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show items in bag for entities in the Tactical Tooltip.");

tacticalTooltipPage.addRangeSetting("CollapseEffectsWhenX", 20, 0, 20, 1, "Collapse Effects When", "While the number of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addRangeSetting("CollapsePerksWhenX", 7, 0, 20, 1, "Collapse Perks When", "While the number of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addBooleanSetting("HeaderForEmptyCategories", false, "Show Header for empty categories");
