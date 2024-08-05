::Reforged.HooksMod.hook("scripts/items/weapons/warhammer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer"));

		this.addSkill(::Reforged.new("scripts/skills/actives/crush_armor"));
	}
});
