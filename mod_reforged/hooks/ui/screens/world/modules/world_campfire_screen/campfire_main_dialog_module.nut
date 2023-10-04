::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module", function(q) {
	q.onUpgradeInventorySpace = @(__original) function()
    {
        __original();
        ::World.State.updateTopbarAssets();     // Makes it so the crowns at the top left update instantly when buying a cart, unlike in vanilla
    }
});
