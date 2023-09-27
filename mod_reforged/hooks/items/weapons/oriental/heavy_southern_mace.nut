::Reforged.HooksMod.hook("scripts/items/weapons/oriental/heavy_southern_mace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.PoiseDamage = 80;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash"));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out"));
	}
});
