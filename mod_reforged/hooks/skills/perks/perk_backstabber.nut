::Reforged.HooksMod.hook("scripts/skills/perks/perk_backstabber", function(q) {
	q.create = @(__original) function()
    {
        __original();
        this.m.Icon = "ui/perks/perk_59.png";   // In vanilla it uses the 'Brawny' Icon but there it doesn't cause issues. However we list this perk in the tactical tooltip.
    }
});
