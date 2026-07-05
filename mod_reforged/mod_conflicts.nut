::Reforged.HooksMod.conflictWith([
	"mod_legends",
	// Better Fencing by LordMidas. https://www.nexusmods.com/battlebrothers/mods/369
	"mod_betterFencing [Is already included and/or enhanced in Reforged]",
	// Items and Recipes by Vazl. https://www.nexusmods.com/battlebrothers/mods/501
	"mod_items_recipes [A similar feature is included in Reforged]",
	// Tactical hit factors by MrBrut. https://www.nexusmods.com/battlebrothers/mods/283
	"mod_tactical_hit_factors [A similar feature is included in Reforged]",
	// Tactical tooltip by MrBrut. https://www.nexusmods.com/battlebrothers/mods/266
	"mod_tactical_tooltip [A similar feature is included in Reforged]",
	// New Champions by LeVilainJoueur https://www.nexusmods.com/battlebrothers/mods/69
	// It overwrites `tactical_entity_manager.setupEntity` and calls the base `actor` class's `makeMiniboss`
	// instead of calling the `makeMiniboss` defined in the entity's own file.
	// This breaks any custom implementation of `makeMiniboss` in entities.
	"tnf_newChampions [Breaks the implementation of champion enemies in Reforged]"
]);

// Some mods don't register with hooks, so we have to check for their existence by their filename
::Reforged.checkConflictWithFilename <- { function checkConflictWithFilename()
{
	local conflicts = {
		//"15 or 27 roster limit for all scenarios" by knowns. https://www.nexusmods.com/battlebrothers/mods/270
		// Overwrites starting scenario files and hasn't been updated in many years.
		"l_native scenarios to ": "15 or 27 roster limit for all scenarios is incompatible with Reforged. It overwrites various vanilla files and has not been updated in many years. Use Origin Customizer by NgGH707 instead from https://www.nexusmods.com/battlebrothers/mods/445",
		// Better Combat Log by AllanniaBB. https://www.nexusmods.com/battlebrothers/mods/105.
		// Overwrites actor.onMovementFinish which breaks our onAnySkillExecutedFully scheduling system for switchEntities.
		"mod_better_combat_log": "Better Combat Log is incompatible with Reforged as it overwrites functions in the actor class that break Reforged behavior. For a compatible mod that shows morale checks in the combat log use MoraleCheck Log by UnauthorizedShell from https://www.nexusmods.com/battlebrothers/mods/663",
		// Detailed Status Effects by LiaAshborn. https://www.nexusmods.com/battlebrothers/mods/103
		// Incompatible because it overwrites getTooltip of actor and player and causes Reforged tactical tooltip to not work.
		"mod_detailed_status_effects": "Detailed Status Effects is incompatible with Reforged. Reforged has its own tactical tooltip which shows the detailed information via nested tooltips.",
		// This filename is used by two mods, both are incompatible for the same reason:
		// Numbers for text by lichtfield. https://www.nexusmods.com/battlebrothers/mods/316.
		// Number's Detailed by wyoian https://www.nexusmods.com/battlebrothers/mods/94.
		// Cause issues because they overwrite config/strings.
		"mod_numbers": "mod_numbers is incompatible with Reforged. Causes enemies to have wrong names. Use More Indirect Numeral Adjectives by UnauthorizedShell instead.",
		// Show Enemy Stats by LiaAshborn. https://www.nexusmods.com/battlebrothers/mods/98
		"mod_show_enemy_stats": "Show Enemy Stats is not compatible with Reforged. A similar feature is already included in Reforged.",
		// Smart Recruiter by Leonionin. https://www.nexusmods.com/battlebrothers/mods/172
		// Conflicts on hiring screen and breaks our perk tree display there
		"mod_smart_recruiter": "Smart Recruiter is not compatible with Reforged. Use Clever Recruiter by Enduriel instead.",
		// A variant file of Smart Recruiter on the same mod page as above.
		"mod_sr_alternative": "Smart Recruiter is not compatible with Reforged. Use Clever Recruiter by Enduriel instead.",
		// Uncapped Levels and Perk Points by KillersToys https://www.nexusmods.com/battlebrothers/mods/260
		// Overwrites config/character.
		"mod_uncapped_levels": "Uncapped Levels and Perk Points is incompatible with Reforged. In Reforged the maximum player level is uncapped.",
		// Part of "Tweaks and Fixes" by LeVilainJoueur. https://www.nexusmods.com/battlebrothers/mods/69
		// Modifies hire screen causing the perk trees from Reforged to not appear there
		"tnf_tryout": "tnf_tryout is incompatible with Reforged. Use Clever Recruiter by Enduriel instead."
	};

	local reforgedFiles = [];

	foreach (filePath in ::IO.enumerateFiles("data/"))
	{
		// Skip patch files
		if (filePath.find("data/mod_reforged") != null && filePath.find("mod_reforged_patch") == null)
		{
			reforgedFiles.push(filePath.slice(5));
			continue;
		}

		foreach (filename, reason in conflicts)
		{
			// Add "data/" because we don't want to check inside subfolders
			if (filePath.find("data/" + filename) != null)
			{
				::Hooks.errorAndQuit(reason);
			}
		}
	}

	local coreCount = 0;
	local assetsCount = 0;
	foreach (filename in reforgedFiles)
	{
		if (filename == "mod_reforged")
		{
			if (reforgedFiles.len() > 1)
			{
				::Hooks.errorAndQuit("You have extra Reforged zip files in your data folder. Delete the extra ones and keep the latest version only.");
			}
			break;
		}

		if (filename.find("mod_reforged_core") != null)
		{
			coreCount++;
		}

		if (filename.find("mod_reforged_assets") != null)
		{
			assetsCount++;
		}
	}

	if (coreCount > 1)
		::Hooks.errorAndQuit("You have extra Reforged core files in your data folder. Delete the extra ones and keep the latest version only.");
	if (assetsCount > 1)
		::Hooks.errorAndQuit("You have extra Reforged assets files in your data folder. Delete the extra ones and keep the latest version only.");
}}.checkConflictWithFilename;
