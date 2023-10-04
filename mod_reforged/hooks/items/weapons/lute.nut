::Reforged.HooksMod.hook("scripts/items/weapons/lute", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 2;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash"));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 10;
		}));
	}
});
