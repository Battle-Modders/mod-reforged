::mods_hookExactClass("items/ammo/large_powder_bag", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ID = "ammo.powder_large";   // Gives this a new unique ID as opposed Vanilla
    }
});
