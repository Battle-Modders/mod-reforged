::Reforged.HooksMod.hook("scripts/items/weapons/dagger", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/stab", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/puncture", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
