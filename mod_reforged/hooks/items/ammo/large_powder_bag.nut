::mods_hookExactClass("items/ammo/large_powder_bag", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ID = "ammo.powder_large";   // Gives this a new unique ID as opposed Vanilla
        this.m.AmmoCost = 2;    // In Vanilla this is 1
        this.m.AmmoTypeName = "bullet";
        this.m.AmmoWeight = 0.5;
    }

    o.getTooltip = o.ammo.getTooltip;
});
