::Reforged.HooksMod.hook("scripts/items/weapons/wooden_stick", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.PoiseDamage = 80;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
