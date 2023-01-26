::Reforged.UI <- {};

::mods_registerJS("mod_reforged/setup.js");
::mods_registerCSS("mod_reforged/generic.css");

::mods_registerJS("mod_reforged/reforged_js_connection.js");
::include("mod_reforged/ui/reforged_js_connection");
::Reforged.UI.JSConnection <- ::new("mod_reforged/ui/reforged_js_connection");
::MSU.UI.registerConnection(::Reforged.UI.JSConnection);
