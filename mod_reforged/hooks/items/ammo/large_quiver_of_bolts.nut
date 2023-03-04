::mods_hookExactClass("items/ammo/large_quiver_of_bolts", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ID = "ammo.bolts_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
