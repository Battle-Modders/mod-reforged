::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.ShieldDamage = 22;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
