::Reforged.HooksMod.hook("scripts/items/weapons/hatchet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 2;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
			o.m.FatigueCost -= 3;
		}));
	}
});
