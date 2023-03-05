::mods_hookExactClass("ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module", function(o) {
	local onUpgradeInventorySpace = o.onUpgradeInventorySpace;
    o.onUpgradeInventorySpace = function()
    {
        onUpgradeInventorySpace();
        ::World.State.updateTopbarAssets();     // Makes it so the crowns at the top left update instantly when buying a cart, unlike in vanilla
    }
});
