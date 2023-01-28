::Reforged.UI <- {};

::mods_registerJS("mod_reforged/setup.js");
::mods_registerCSS("mod_reforged/generic.css");

::mods_registerJS("mod_reforged/reforged_js_connection.js");
::include("mod_reforged/ui/reforged_js_connection");
::Reforged.UI.JSConnection <- ::new("mod_reforged/ui/reforged_js_connection");
::MSU.UI.registerConnection(::Reforged.UI.JSConnection);

::mods_registerJS("mod_reforged/setup.js");

local prefixLen = "ui/mods/".len();
foreach(file in this.IO.enumerateFiles("ui/mods/mod_reforged/hooks"))
{
	file = file.slice(prefixLen) + ".js";
	::mods_registerJS(file);
}
