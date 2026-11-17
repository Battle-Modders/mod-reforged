{ // General page
	local generalPage = ::Reforged.Mod.ModSettings.addPage("General", "General");

	generalPage.addTitle("General_Title_Misc", "Misc");

	generalPage.addEnumSetting("CraftingBlueprintVisibility", "One Ingredient Available", ["Always", "One Ingredient Available", "All Ingredients Available", "Vanilla"], "Blueprints Visible When", "Crafting Recipes in the Taxidermist will be displayed when this condition is met.\nNote that individual Blueprints (like Snake Oil) may still have custom rules preventing them from being shown.\n\n\'Vanilla\' means that the visibility behavior is unchanged from how it works in the base game.");
	generalPage.addBooleanSetting("ConfirmSkillUse", false, "Confirm Skill Use", "If enabled, skills that are normally used immediately (e.g. Shieldwall, Rally) will instead require you to target your character. This allows you to preview Action Point and Fatigue costs and the predicted affordability of other skills. Hold the \'Confirm Skill Use\' key (default Ctrl) to bypass this and use the skill immediately.\n\nIf disabled, these skills are used immediately as in vanilla, but the keybind can be used to preview them and require confirmation.");

	generalPage.addDivider("MiscDivider1");
	generalPage.addTitle("General_Title_Contracts", "Contracts");
	generalPage.addEnumSetting("SkipContractsToScreen", "Disabled", ["Disabled", "Negotiation", "Overview"], "Skip Contracts To", "Allows you to save some time by skipping to a certain screen when opening a contract in settlements.\n\nDisabled: Same behavior as vanilla, you have to click through all of the contract\'s screens.\n\nNegotiation: Skip the introduction screens and go straight to the negotiation.\n\nOverview: Skip to the final screen in the contract where you can accept or reject it. With this option, you will no longer be able to manually negotiate contracts.");
	generalPage.addRangeSetting("AutoNegotiateAttempts", 0, 0, 10, 1, "Auto-Negotiate Attempts", "When clicking on contracts in settlements, auto-negotiate them this many times for more payment. This process will stop as soon as the employer rejects a negotiation attempt (i.e. did not increase his offer), or the negotiations fail.");
}
{ // Tooltips page
	local tooltipsPage = ::Reforged.Mod.ModSettings.addPage("Tooltips", "Tooltips");

	tooltipsPage.addTitle("Tooltips_Title_CharacterScreen", "Character Screen");

	tooltipsPage.addBooleanSetting("CharacterScreen_ShowAttributeProjection", true, "Show Attribute Projection", "If enabled, the character background tooltip will display projected attribute values, estimating how much each attribute could grow if all level-ups are invested into that attribute.");
	tooltipsPage.addBooleanSetting("CharacterScreen_ShowBaseAttributeRangesHiring", true, "Show Base Attribute Ranges (Hiring)", "If enabled, the maximum and minimum Base Attribute Ranges for every background is displayed during Hiring, when hovering over the background icon.");
	tooltipsPage.addEnumSetting("CharacterScreen_ShowBaseAttributeRangesRegular", "Only New Recruits", ["Always", "Only New Recruits", "Never"], "Show Base Attribute Ranges (Regular)", "When this condition is met, the minimum and maximum Base Attribute Ranges for backgrounds are displayed, when looking at their tooltips. \'Only New Recruits\' stops displaying the info, once you have spent one level-up.");

	tooltipsPage.addDivider("Tooltips_Divider1");
	tooltipsPage.addTitle("Tooltips_Title_TacticalTooltips", "Characters in Combat");

	tooltipsPage.addEnumSetting("TacticalTooltip_Values", "All", ["All", "AI Only", "Player Only", "None"], "Show Values", "Show Hitpoints, Armor etc. as values instead of immersive words.");
	tooltipsPage.addEnumSetting("TacticalTooltip_Attributes", "All", ["All", "AI Only", "Player Only", "None"], "Show Attributes", "Show attributes such as Melee Skill, Melee Defense etc. for entities in the Tactical Tooltip.");
	tooltipsPage.addEnumSetting("TacticalTooltip_Effects", "All", ["All", "AI Only", "Player Only", "None"], "Show Effects", "Show status effects for entities in the Tactical Tooltip.");
	tooltipsPage.addEnumSetting("TacticalTooltip_Perks", "All", ["All", "AI Only", "Player Only", "None"], "Show Perks", "Show perks for entities in the Tactical Tooltip.");
	tooltipsPage.addEnumSetting("TacticalTooltip_EquippedItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Equipped Items", "Show equipped items for entities in the Tactical Tooltip.");
	tooltipsPage.addEnumSetting("TacticalTooltip_BagItems", "All", ["All", "AI Only", "Player Only", "None"], "Show Bag Items", "Show items in bag for entities in the Tactical Tooltip.");
	tooltipsPage.addEnumSetting("TacticalTooltip_ActiveSkills", "All", ["All", "AI Only", "Player Only", "None"], "Show Active Skills", "Show all the usable active skills for entities in the Tactical Tooltip.");
	tooltipsPage.addRangeSetting("TacticalTooltip_CollapseEffectsWhenX", 5, 0, 20, 1, "Collapse Effects When", "While the number of effects is below this value all effects display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tooltipsPage.addRangeSetting("TacticalTooltip_CollapsePerksWhenX", 5, 0, 20, 1, "Collapse Perks When", "While the number of perks is below this value all perks display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tooltipsPage.addRangeSetting("TacticalTooltip_CollapseActivesWhenX", 5, 0, 20, 1, "Collapse Actives When", "While the number of active skills is below this value they display their icon and use a separate line. Otherwise they combine into a single block of text in order to save space.");
	tooltipsPage.addBooleanSetting("TacticalTooltip_CollapseAsText", false, "Collapse as Text", "If enabled, then skills collapse using their names as text, otherwise they collapse using their icons.");
	tooltipsPage.addBooleanSetting("TacticalTooltip_ShowStatusPerkAndEffect", true, "Show Status Perk And Effect", "Some Perks are also Status Effects. Usually their Effect is hidden until some condition is fulfilled. When this setting is enabled, these perks show up in the Perks category even when they show up under Effects (e.g. when their effect is active). When disabled, when they appear under Effects, they will be hidden from the Perks category. This can help save space on the tooltip.");
	tooltipsPage.addBooleanSetting("TacticalTooltip_HeaderForEmptyCategories", false, "Show Header for empty categories");

	// Hit-chance overlay and the movement preview tile tooltip (::Reforged.HitchanceOverlay)
	tooltipsPage.addDivider("Tooltips_Divider2");
	tooltipsPage.addTitle("Tooltips_Title_HitChances", "Predicted Hit Chances");
	// The option array is the cycle order of the topbar button and the keybind; descriptions: ::Reforged.HitchanceOverlay.__Modes
	tooltipsPage.addEnumSetting("HitchanceDisplay_Mode", "Overlay", ["Overlay", "Overlay + Tooltip", "Tooltip", "Off"], "Hit Chance Display", "How predicted chances to hit and to be hit are shown in combat: while your character whose turn it is previews a movement (from the tile you clicked) or has an attack selected (that attack, from his current tile), and while you hover one of your characters (from his current tile).\n\nOverlay: small labels next to opponents.\nTooltip: a list in the tooltip of the tile during movement preview.\n\nThe topbar button and the \'Cycle Hit Chance Display\' key (default V) cycle through these options.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.onModeChanged());
	tooltipsPage.addEnumSetting("HitchanceDisplay_Shown", "All", ["All", "AI Only", "Player Only", "None"], "Shown Hit Chances", "Which predicted hit chances are shown in the overlay and the tooltip. Player Only: chances of your character to hit opponents. AI Only: chances of opponents to hit your character.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addEnumSetting("HitchanceDisplay_ZOCAttacks", "Always", ["Always", "Follow Display Settings"], "Attacks on Movement", "Attacks of opponents when your character leaves their zone of control or arrives next to them (e.g. Spearwall) during movement preview.\n\nAlways: listed in the tooltip of the tile, whatever the \'Hit Chance Display\' and \'Shown Hit Chances\' settings, and marked by a warning icon on overlay labels.\n\nFollow Display Settings: shown only like the chances of opponents to hit your character.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addEnumSetting("HitchanceOverlay_EnemyAttack", "Primary Attack", ["Primary Attack", "Best Hit Chance"], "Opponent Attack", "Which attack of an opponent its predicted chance to hit your character is shown for, in the overlay and the tooltip.\n\nPrimary Attack: its first attack in skill bar order that can reach your character, usually the attack of its main weapon.\n\nBest Hit Chance: whichever of its attacks has the highest chance to hit.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addRangeSetting("HitchanceDisplay_CollapseThreshold", 5, 0, 100, 1, "Tooltip Collapse Threshold", "In the tooltip during movement preview, opponents with a predicted hit chance equal to this or less are collapsed into a single tooltip entry.");

	tooltipsPage.addDivider("Tooltips_Divider3");
	tooltipsPage.addTitle("Tooltips_Title_HitchanceOverlay", "Hit-Chance Overlay Labels");
	tooltipsPage.addEnumSetting("HitchanceOverlay_LabelInteraction", "Hoverable", ["Hoverable", "Click-through"], "Overlay Label Interaction", "Hoverable: hovering an overlay label shows details in a tooltip. While the mouse is over a label, the tile below it can't be hovered, e.g. for movement preview. Hold the \'Hit Chance Overlay Interaction\' key (default X) to make the labels click-through.\n\nClick-through: the labels never block the map. Hold the key to make them hoverable.");
	tooltipsPage.addEnumSetting("HitchanceOverlay_Style", "Skill Icons", ["Compact", "Skill Icons", "Parchment"], "Overlay Label Style", "Compact: a sword pointing at the opponent for your character\'s chance to hit it and a sword pointing back for its chance to hit your character, without a background.\n\nSkill Icons: the icons of the attacking skills instead of the swords, without a background.\n\nParchment: a parchment label with the icons of the attacking skills.\n\nA warning icon marks opponents that attack your character when he moves (zone of control) or arrives (e.g. Spearwall). The label\'s tooltip shows the details.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addEnumSetting("HitchanceOverlay_Placement", "Beside", ["Beside", "Above"], "Overlay Label Placement", "Beside: a vertical label at the outer corner of the unit\'s hex, at torso height.\n\nAbove: a horizontal label above the unit\'s head and its health bars. It can cover the unit on the tile above.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addRangeSetting("HitchanceOverlay_Scale", 0.7, 0.4, 1.5, 0.05, "Overlay Label Size", "Size multiplier of the overlay labels. They also shrink when you zoom out.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addRangeSetting("HitchanceOverlay_ParchmentOpacity", 1.0, 0.0, 1.0, 0.05, "Parchment Opacity", "Opacity of the parchment background of overlay labels in the Parchment style.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addRangeSetting("HitchanceOverlay_ContentOpacity", 1.0, 0.0, 1.0, 0.05, "Overlay Content Opacity", "Opacity of the icons and values of overlay labels in all styles.").addAfterChangeCallback(@( _newValue ) ::Reforged.HitchanceOverlay.setDirty());
	tooltipsPage.addRangeSetting("HitchanceOverlay_FadeTime", 0, 0, 500, 10, "Overlay Fade Time (ms)", "How long overlay labels take to fade in and out. 0 shows and hides them instantly.");
}
{ // Debug page
	local debugPage = ::Reforged.Mod.ModSettings.addPage("Debug", "Debug & Dev");
	debugPage.addBooleanSetting("Debug_onAnySkillExecutedFully", true, "onAnySkillExecutedFully", "Enable for debug logging of onAnySkillExecutedFully module").addBeforeChangeCallback(@( _newValue ) ::Reforged.Mod.Debug.setFlag(::Reforged.DebugFlag.onAnySkillExecutedFully, _newValue));
	debugPage.addBooleanSetting("Debug_AIAgentFixes", false, "AIAgentFixes", "Enable for debug logging of AIAgentFixes module").addBeforeChangeCallback(@( _newValue ) ::Reforged.Mod.Debug.setFlag(::Reforged.DebugFlag.AIAgentFixes, _newValue));

	debugPage.addTitle("Title_DevOptions", "Dev Options");
	debugPage.addBooleanSetting("Dev_SpawnsInfo", false, "Spawns Info", "Enable display of various information about spawns on the world map such as party cost/strength, spawn day etc.");
}
{ // Keybinds
	::Reforged.Mod.Keybinds.addSQKeybind("Tactical_WaitRound", "h", ::MSU.Key.State.Tactical, function()
	{
		if (this.m.MenuStack.hasBacksteps() || this.isInputLocked() || this.isInCharacterScreen())
		{
			return false;
		}
		else
		{
			::Tactical.TurnSequenceBar.RF_onWaitTurnAllButtonPressed();
			return true;
		}
	}, "Wait Turn with all Characters");

	::Reforged.Mod.Keybinds.addSQKeybind("Tactical_PauseAI", "ctrl+space", ::MSU.Key.State.Tactical, function()
	{
		if (!::Tactical.isActive() || this.m.MenuStack.hasBacksteps() || this.isInCharacterScreen())
		{
			return false;
		}
		else
		{
			local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
			// We only allow pausing, while it is not the players turn, in order to prevent buffering inputs which can cause buggy behavior
			if (::Tactical.State.isPaused() || activeEntity == null || !activeEntity.isPlayerControlled())
			{
				::Tactical.State.setPause(!::Tactical.State.isPaused());
			}

			return true;
		}
	}, "Pause Tactical Combat");

	::Reforged.Mod.Keybinds.addSQKeybind("ConfirmSkillUseKeybind", "ctrl", ::MSU.Key.State.Tactical, @() true, "Confirm Skill Use", null, "Used to toggle the confirmation requirement for skills that are normally used immediately (e.g. Shieldwall, Rally). It allows you to either preview the Action Point and Fatigue costs or bypass confirmation, depending on your \'Confirm Skill Use\' setting.");

	::Reforged.Mod.Keybinds.addSQKeybind("Tactical_CycleHitchanceDisplay", "v", ::MSU.Key.State.Tactical, function()
	{
		if (this.m.MenuStack.hasBacksteps() || this.isInCharacterScreen())
			return false;

		::Reforged.HitchanceOverlay.cycleMode();
		return true;
	}, "Cycle Hit Chance Display", null, "Cycles the \'Hit Chance Display\' setting: Overlay, Overlay + Tooltip, Tooltip, Off.");

	::Reforged.Mod.Keybinds.addJSKeybind("Tactical_HitchanceOverlayInteraction", "x", "Hit Chance Overlay Interaction", "Hold to invert the \'Overlay Label Interaction\' setting: hoverable labels become click-through and vice versa.");

	::Reforged.Mod.Keybinds.addSQKeybind("ToggleReforgedDevMode", "ctrl+tab", ::MSU.Key.State.All, function() { ::Reforged.__toggleDevMode(); return true; }, "Toggle Reforged Dev Mode", null, "Used to toggle Dev mode for Reforged. This enables/disables the various Dev mode settings all at once.");
}
