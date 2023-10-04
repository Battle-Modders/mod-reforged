::Reforged.HooksMod.hook("scripts/items/weapons/noble_sword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
