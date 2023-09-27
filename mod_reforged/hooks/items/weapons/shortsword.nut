::Reforged.HooksMod.hook("scripts/items/weapons/shortsword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
