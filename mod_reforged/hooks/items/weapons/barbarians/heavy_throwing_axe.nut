::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/heavy_throwing_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/throw_axe", function(o) {
			o.m.FatigueCost += 1;
		}));
	}
});
