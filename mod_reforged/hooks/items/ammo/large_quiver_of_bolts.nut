::Reforged.HooksMod.hook("scripts/items/ammo/large_quiver_of_bolts", function(q) {
    q.create = @(__original) function()
    {
        __original();
        this.m.ID = "ammo.bolts_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
