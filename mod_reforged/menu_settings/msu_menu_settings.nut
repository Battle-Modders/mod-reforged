// All MSU settings in the options menu for reforged are being created here

// ### MISC ### - Basically everything that doesn't fit in another category
local misc = ::Reforged.Mod.ModSettings.addPage("Misc");

local myEnumTooltip = "Define how Blueprints are shown: 'All Ingredients Available' is the Vanilla behavior; 'One Ingredient Available' shows recipes when one ingredient is fully satisfied; 'Always' shows all recipes at all time";
misc.addElement(::MSU.Class.EnumSetting("ShowBlueprintsWhen", "All Ingredients Available", ["All Ingredients Available", "One Ingredient Available", "Always"], "Show Blueprints when", myEnumTooltip));
