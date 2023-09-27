::Reforged.HooksMod.hook("scripts/items/weapons/warhammer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/hammer"));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor"));
	}
});
