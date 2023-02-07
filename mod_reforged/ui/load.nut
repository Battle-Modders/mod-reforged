::Reforged.UI <- {};

::mods_registerJS("mod_reforged/setup.js");
::mods_registerCSS("mod_reforged/generic.css");
::mods_registerCSS("mod_reforged/controls.css");

::mods_registerJS("mod_reforged/reforged_js_connection.js");
::include("mod_reforged/ui/reforged_js_connection");
::Reforged.UI.JSConnection <- ::new("mod_reforged/ui/reforged_js_connection");
::MSU.UI.registerConnection(::Reforged.UI.JSConnection);

local prefixLen = "ui/mods/".len();
foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/js_hooks"))
{
	::mods_registerJS(file.slice(prefixLen) + ".js");
}
foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/css_hooks"))
{
	::mods_registerCSS(file.slice(prefixLen) + ".css");
}
