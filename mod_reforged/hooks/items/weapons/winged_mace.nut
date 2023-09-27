::Reforged.HooksMod.hook("scripts/items/weapons/winged_mace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash"));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out"));
	}
});
