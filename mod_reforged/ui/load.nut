::Reforged.UI <- {};

::Hooks.registerJS("ui/mods/mod_reforged/setup.js");
::Hooks.registerJS("ui/mods/mod_reforged/reforged_assets.js");
::Hooks.registerCSS("ui/mods/mod_reforged/generic.css");
::Hooks.registerCSS("ui/mods/mod_reforged/controls.css");

::Hooks.registerJS("ui/mods/mod_reforged/reforged_js_connection.js");
::include("mod_reforged/ui/reforged_js_connection");
::Reforged.UI.JSConnection <- ::new("mod_reforged/ui/reforged_js_connection");
::MSU.UI.registerConnection(::Reforged.UI.JSConnection);

local lateJS = [
	"ui/mods/mod_reforged/js_hooks/screens/menu/modules/main_menu/main_menu_module"
]

foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/js_hooks"))
{
	if (lateJS.find(file) != null)
		::Hooks.registerLateJS(file + ".js");
	else
		::Hooks.registerJS(file + ".js");
}
foreach(file in ::IO.enumerateFiles("ui/mods/mod_reforged/css_hooks"))
{
	::Hooks.registerCSS(file + ".css");
}
