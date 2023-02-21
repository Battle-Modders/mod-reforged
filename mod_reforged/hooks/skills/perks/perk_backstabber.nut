::mods_hookExactClass("skills/perks/perk_backstabber", function (o) {
	local create = o.create;
    o.create = function()
    {
        create();
        this.m.Icon = "ui/perks/perk_59.png";   // In vanilla it uses the 'Brawny' Icon but there it doesn't cause issues. However we list this perk in the tactical tooltip.
    }
});
