::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_metal_club", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out"));
	}
});
