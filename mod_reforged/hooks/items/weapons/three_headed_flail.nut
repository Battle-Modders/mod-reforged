::Reforged.HooksMod.hook("scripts/items/weapons/three_headed_flail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/hail_skill"));
	}
});
