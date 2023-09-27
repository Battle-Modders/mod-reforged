::Reforged.HooksMod.hook("scripts/items/weapons/oriental/nomad_mace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
