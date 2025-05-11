::Reforged.HooksMod.conflictWith([
	"mod_legends",
	// Weapon Mastery Standardization by LordMidas. https://www.nexusmods.com/battlebrothers/mods/366
	"mod_WMS [Is already included and/or enhanced in Reforged]",
	// Better Fencing by LordMidas. https://www.nexusmods.com/battlebrothers/mods/369
	"mod_betterFencing [Is already included and/or enhanced in Reforged]",
	// Tactical hit factors by MrBrut. https://www.nexusmods.com/battlebrothers/mods/283
	"mod_tactical_hit_factors [A similar feature is included in Reforged]",
	// Tactical tooltip by MrBrut. https://www.nexusmods.com/battlebrothers/mods/266
	"mod_tactical_tooltip [A similar feature is included in Reforged]"
]);

// Some mods don't register with hooks, so we have to check for their existence by their filename
::Reforged.checkConflictWithFilename <- function()
{
	local conflicts = {
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
		// Uncapped Levels and Perk Points by KillersToys https://www.nexusmods.com/battlebrothers/mods/260
		// Overwrites config/character.
		"mod_uncapped_levels": "Uncapped Levels and Perk Points is incompatible with Reforged. In Reforged the maximum player level is uncapped.",
		// Part of "Tweaks and Fixes" by LeVilainJoueur. https://www.nexusmods.com/battlebrothers/mods/69
		// Modifies hire screen causing the perk trees from Reforged to not appear there
		"tnf_tryout": "tnf_tryout is incompatible with Reforged. Use Clever Recruiter by Enduriel instead."
	};
	foreach (filePath in ::IO.enumerateFiles("data/"))
	{
		foreach (filename, reason in conflicts)
		{
			// Add "data/" because we don't want to check inside subfolders
			if (filePath.find("data/" + filename) != null)
			{
				::Hooks.errorAndQuit(reason);
			}
		}
	}
}
