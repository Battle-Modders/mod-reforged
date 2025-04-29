::Reforged.HooksMod.conflictWith([
	"mod_legends",
	// Weapon Mastery Standardization by LordMidas. https://www.nexusmods.com/battlebrothers/mods/366
	"mod_WMS [Is already included and/or enhanced in Reforged]",
	// Better Fencing by LordMidas. https://www.nexusmods.com/battlebrothers/mods/369
	"mod_betterFencing [Is already included and/or enhanced in Reforged]",
	// This id is used by two mods, both are incompatible for the same reason:
	// Numbers for text by lichtfield. https://www.nexusmods.com/battlebrothers/mods/316.
	// Number's Detailed by wyoian https://www.nexusmods.com/battlebrothers/mods/94.
	// Cause issues because they overwrite config/strings.
	"mod_numbers [Causes enemies to have wrong names. Use More Indirect Numeral Adjectives by UnauthorizedShell instead]",
	// Tactical hit factors by MrBrut. https://www.nexusmods.com/battlebrothers/mods/283
	"mod_tactical_hit_factors [A similar feature is included in Reforged]",
	// Tactical tooltip by MrBrut. https://www.nexusmods.com/battlebrothers/mods/266
	"mod_tactical_tooltip [A similar feature is included in Reforged]"
]);

// Some mods don't register with hooks, so we have to check for their existence by their filename
::Reforged.checkConflictWithFilename <- function()
{
	local conflicts = {
		// Show Enemy Stats by LiaAshborn. https://www.nexusmods.com/battlebrothers/mods/98
		"mod_show_enemy_stats": "Show Enemy Stats is not compatible with Reforged. A similar feature is already included in Reforged.",
		// Smart Recruiter by Leonionin. https://www.nexusmods.com/battlebrothers/mods/172
		// Conflicts on hiring screen and breaks our perk tree display there
		"mod_smart_recruiter": "Smart Recruiter is not compatible with Reforged. Use Clever Recruiter by Enduriel instead."
	};
	foreach (filePath in ::IO.enumerateFiles("data/"))
	{
		foreach (filename, reason in conflicts)
		{
			if (filePath.find(filename) != null)
			{
				::Hooks.errorAndQuit(reason);
			}
		}
	}
}
