local tacticalTooltipPage = ::Reforged.Mod.ModSettings.addPage("Tactical Tooltips");

tacticalTooltipPage.addEnumSetting("TacticalTooltip_Attributes", "All", ["All", "AI Only", "Player Only", "None"], "Show Attributes", "Show attributes such as Melee Skill, Melee Defense etc. for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_Effects", "All", ["All", "AI Only", "Player Only", "None"], "Show Effects", "Show status effects for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_Perks", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show perks for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_EquippedItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Equipped Items", "Show equipped items for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_BagItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Bag Items", "Show items in bag for entities in the Tactical Tooltip.");
tacticalTooltipPage.addEnumSetting("TacticalTooltip_ActiveSkills", "All", ["All", "AI Only", "Player Only", "None"], "Show Active Skills", "Show all the usable active skills for entities in the Tactical Tooltip.");

tacticalTooltipPage.addRangeSetting("TacticalTooltip_Reach", 0, 0, 20, 1);
tacticalTooltipPage.addBooleanSetting("TacticalTooltip_ReachEye", true);

tacticalTooltipPage.addRangeSetting("CollapseEffectsWhenX", 5, 0, 20, 1, "Collapse Effects When", "While the number of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addRangeSetting("CollapsePerksWhenX", 5, 0, 20, 1, "Collapse Perks When", "While the number of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addRangeSetting("CollapseActivesWhenX", 5, 0, 20, 1, "Collapse Actives When", "While the number of active skills is below this value they display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
tacticalTooltipPage.addBooleanSetting("TacticalTooltip_CollapseAsText", false, "Collapse as Text", "If enabled, then skills collapse using their names as text, otherwise they collapse using their icons.");
tacticalTooltipPage.addBooleanSetting("ShowStatusPerkAndEffect", true, "Show Status Perk And Effect", "Some Perks are also Status Effects. Usually their Effect is hidden until some condition is fulfilled. When this setting is enabled, these perks show up in the Perks category even when they show up under Effects (e.g. when their effect is active). When disabled, when they appear under Effects, they will be hidden from the Perks category. This can help save space on the tooltip.");
tacticalTooltipPage.addBooleanSetting("HeaderForEmptyCategories", false, "Show Header for empty categories");
