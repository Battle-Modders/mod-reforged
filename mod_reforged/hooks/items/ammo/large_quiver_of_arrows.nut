::mods_hookExactClass("items/ammo/large_quiver_of_arrows", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ID = "ammo.arrows_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
