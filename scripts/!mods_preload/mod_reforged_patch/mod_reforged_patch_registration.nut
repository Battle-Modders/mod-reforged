/*
## What is a patch?
A patch is NOT a complete Reforged build. Instead, it is meant to contain only a few files
that have changes in them meant to fix a specific issue for a user or to "field-test" the fix
for a specific issue before it is included in the main build.

## How to make a patch:
- Rename this .nut file to a unique filename for each patch (not each version of that patch).
- Give each patch a unique ID and Name.
  - ID format: mod_reforged_patch_patchID
  - e.g. mod_reforged_patch_tactical_tooltip_fix
- Each patch then has its own versioning sequence.
  - e.g. mod_reforged_patch_tactical_tooltip_fix 1.0.0, then 2.0.0 and so on.
- Put the changes of the patch into a branch called "patch", basing that branch
onto the intended branch of Reforged (e.g. main or development). Then use BBBuilder
to build the diff between that branch and patch.
  - Command: BBBuilder.exe build "REFORGED_PATH" -diff development,patch
*/
local t = {
	Version = "1.0.0", // Each patch has its own versioning starting at 1.0.0.
	ID = "", // ID must be unique for each patch.
	Name = "Reforged Patch", // Give each patch a unique name.
};

if (t.ID == "")
	return;

local hooksMod = ::Hooks.register(t.ID, t.Version, t.Name);

// This ensures that subsequent builds of Reforged require the user to remove this patch.
hooksMod.require("mod_reforged <= " + ::Reforged.Version);
