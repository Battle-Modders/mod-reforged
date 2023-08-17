::mods_hookExactClass("items/ammo/quiver_of_bolts", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.AmmoTypeName = "bolt";
        this.m.AmmoWeight = 0.2;
    }

    o.getTooltip = o.ammo.getTooltip;
});
