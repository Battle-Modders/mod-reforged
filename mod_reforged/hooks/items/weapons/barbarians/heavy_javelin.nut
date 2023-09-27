::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/heavy_javelin", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/throw_javelin", function(o) {
			o.m.FatigueCost += 1;
		}));
	}
});
