::Reforged.HooksMod.hook("scripts/items/ammo/large_quiver_of_arrows", function(q) {
    q.create = @(__original) function()
    {
        __original();
        this.m.ID = "ammo.arrows_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
