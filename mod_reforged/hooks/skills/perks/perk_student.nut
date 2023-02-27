::mods_hookExactClass("skills/perks/perk_student", function (o) {
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.IsRefundable = false;
    }
});
