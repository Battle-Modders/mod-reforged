::Reforged.HooksMod.hook("scripts/items/weapons/knife", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/stab", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/puncture", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
