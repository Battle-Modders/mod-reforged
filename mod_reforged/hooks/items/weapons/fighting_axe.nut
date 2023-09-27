::Reforged.HooksMod.hook("scripts/items/weapons/fighting_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.ShieldDamage = 18;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true)
		}));
	}
});
