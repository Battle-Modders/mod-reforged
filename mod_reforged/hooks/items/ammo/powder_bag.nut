::mods_hookExactClass("items/ammo/powder_bag", function(o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.AmmoCost = 2;    // In Vanilla this is 1
        this.m.AmmoTypeName = "bullet";
        this.m.AmmoWeight = 0.4;
    }

    o.getTooltip = o.ammo.getTooltip;
});
