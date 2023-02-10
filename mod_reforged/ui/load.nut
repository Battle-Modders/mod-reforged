::Reforged.UI <- {};

::MSU.registerEarlyJSHook("mod_reforged/setup.js");
::MSU.registerEarlyJSHook("mod_reforged/reforged_assets.js");
::mods_registerCSS("mod_reforged/generic.css");
::mods_registerCSS("mod_reforged/controls.css");

::MSU.registerEarlyJSHook("mod_reforged/reforged_js_connection.js");
::include("mod_reforged/ui/reforged_js_connection");
::Reforged.UI.JSConnection <- ::new("mod_reforged/ui/reforged_js_connection");
::MSU.UI.registerConnection(::Reforged.UI.JSConnection);

local prefixLen = "ui/mods/".len();
foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/js_hooks"))
{
	::MSU.registerEarlyJSHook(file.slice(prefixLen) + ".js");
}
foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/css_hooks"))
{
	::mods_registerCSS(file.slice(prefixLen) + ".css");
}

::mods_registerJS("mod_reforged/register_reforged_screens.js");
