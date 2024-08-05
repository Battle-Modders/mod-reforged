::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/heavy_throwing_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/throw_axe", function(o) {
			o.m.FatigueCost += 1;
		}));
	}
});
