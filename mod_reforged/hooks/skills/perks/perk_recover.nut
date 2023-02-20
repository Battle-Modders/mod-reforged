::mods_hookExactClass("skills/perks/perk_shield_expert", function (o) {
	local create = o.create;
    o.create = function()
    {
        create();
        this.m.Icon = "ui/perks/perk_54.png";   // In vanilla it uses the 'Student' Icon but there it doesn't matter. However we list this perk in the tactical tooltip.
    }
});
