::Reforged.HooksMod.hook("scripts/items/weapons/military_pick", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/hammer", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
