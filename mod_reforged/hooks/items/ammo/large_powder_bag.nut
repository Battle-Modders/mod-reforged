::Reforged.HooksMod.hook("scripts/items/ammo/large_powder_bag", function(q) {
    q.create = @(__original) function()
    {
        __original();
        this.m.ID = "ammo.powder_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
