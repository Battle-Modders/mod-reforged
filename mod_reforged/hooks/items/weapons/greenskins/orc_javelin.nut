::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_javelin", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/throw_javelin", function(o) {
			o.m.FatigueCost += 1;
		}));
	}
});
