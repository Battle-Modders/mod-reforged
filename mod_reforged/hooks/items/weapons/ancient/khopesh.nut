::Reforged.HooksMod.hook("scripts/items/weapons/ancient/khopesh", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave"));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate"));
	}
});
