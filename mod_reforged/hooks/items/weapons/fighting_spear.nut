::Reforged.HooksMod.hook("scripts/items/weapons/fighting_spear", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust"));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall"));
	}
});
