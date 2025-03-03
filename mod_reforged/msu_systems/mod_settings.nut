{	// Character Screen
	local characterScreenPage = ::Reforged.Mod.ModSettings.addPage("Character Screen");

	characterScreenPage.addBooleanSetting("CharacterScreen_ShowAttributeProjection", true, "Show Attribute Projection", "If enabled, the character background tooltip will display projected attribute values, estimating how much each attribute could grow if all level-ups are invested into that attribute.");

	characterScreenPage.addDivider("MiscDivider1");
	characterScreenPage.addBooleanSetting("CharacterScreen_ShowBaseAttributeRangesHiring", true, "Show Base Attribute Ranges (Hiring)", "If enabled, the maximum and minimum Base Attribute Ranges for every background is displayed during Hiring, when hovering over the background icon.");
	characterScreenPage.addEnumSetting("CharacterScreen_ShowBaseAttributeRangesRegular", "Only New Recruits", ["Always", "Only New Recruits", "Never"], "Show Base Attribute Ranges (Regular)", "When this condition is met, the minimum and maximum Base Attribute Ranges for backgrounds are displayed, when looking at their tooltips. \'Only New Recruits\' stops displaying the info, once you have spent one level-up.");
}

{	// Tactical Tooltips
	local tacticalTooltipPage = ::Reforged.Mod.ModSettings.addPage("Tactical Tooltips");

	tacticalTooltipPage.addEnumSetting("TacticalTooltip_Attributes", "All", ["All", "AI Only", "Player Only", "None"], "Show Attributes", "Show attributes such as Melee Skill, Melee Defense etc. for entities in the Tactical Tooltip.");
	tacticalTooltipPage.addEnumSetting("TacticalTooltip_Effects", "All", ["All", "AI Only", "Player Only", "None"], "Show Effects", "Show status effects for entities in the Tactical Tooltip.");
	tacticalTooltipPage.addEnumSetting("TacticalTooltip_Perks", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show perks for entities in the Tactical Tooltip.");
	tacticalTooltipPage.addEnumSetting("TacticalTooltip_EquippedItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Equipped Items", "Show equipped items for entities in the Tactical Tooltip.");
	tacticalTooltipPage.addEnumSetting("TacticalTooltip_BagItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Bag Items", "Show items in bag for entities in the Tactical Tooltip.");
	tacticalTooltipPage.addEnumSetting("TacticalTooltip_ActiveSkills", "All", ["All", "AI Only", "Player Only", "None"], "Show Active Skills", "Show all the usable active skills for entities in the Tactical Tooltip.");

	tacticalTooltipPage.addRangeSetting("CollapseEffectsWhenX", 5, 0, 20, 1, "Collapse Effects When", "While the number of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tacticalTooltipPage.addRangeSetting("CollapsePerksWhenX", 5, 0, 20, 1, "Collapse Perks When", "While the number of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tacticalTooltipPage.addRangeSetting("CollapseActivesWhenX", 5, 0, 20, 1, "Collapse Actives When", "While the number of active skills is below this value they display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tacticalTooltipPage.addBooleanSetting("TacticalTooltip_CollapseAsText", false, "Collapse as Text", "If enabled, then skills collapse using their names as text, otherwise they collapse using their icons.");
	tacticalTooltipPage.addBooleanSetting("ShowStatusPerkAndEffect", true, "Show Status Perk And Effect", "Some Perks are also Status Effects. Usually their Effect is hidden until some condition is fulfilled. When this setting is enabled, these perks show up in the Perks category even when they show up under Effects (e.g. when their effect is active). When disabled, when they appear under Effects, they will be hidden from the Perks category. This can help save space on the tooltip.");
	tacticalTooltipPage.addBooleanSetting("HeaderForEmptyCategories", false, "Show Header for empty categories");
}

{	// Misc
	local miscTooltipPage = ::Reforged.Mod.ModSettings.addPage("Misc");
	miscTooltipPage.addEnumSetting("CraftingBlueprintVisibility", "One Ingredient Available", ["Always", "One Ingredient Available", "All Ingredients Available", "Vanilla"], "Blueprints Visible When", "Crafting Recipes in the Taxidermist will be displayed when this condition is met.\nNote that individual Blueprints (like Snake Oil) may still have custom rules preventing them from being shown.\n\n\'Vanilla\' means that the visibility behavior is unchanged from how it works in the base game.");
	miscTooltipPage.addBooleanSetting("AllSkillsTargeted", false, "All Skills Targeted", "Causes all skills to behave as targeted skills so that non-targeted skills such as Shieldwall, Rally the Troops etc. require you to click them to enable the skill preview mode and then use those skills on your character. This has the benefit of allowing you to preview the costs of those skills.")
}

::Reforged.Mod.Keybinds.addSQKeybind("Tactical_WaitRound", "h", ::MSU.Key.State.Tactical, function()
{
	if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen())
	{
		return false;
	}
	else
	{
		::Tactical.TurnSequenceBar.onWaitTurnAllButtonPressed();
		return true;
	}
}, "Wait Turn with all Characters");
