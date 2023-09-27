::Reforged.HooksMod.hook("scripts/items/weapons/military_cleaver", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave"));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));
	}
});
