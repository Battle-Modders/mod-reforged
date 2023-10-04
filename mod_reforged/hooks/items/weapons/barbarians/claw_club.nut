::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/claw_club", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_183.png";
			o.m.IconDisabled = "skills/active_183_sw.png";
			o.m.Overlay = "active_183";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_186.png";
			o.m.IconDisabled = "skills/active_186_sw.png";
			o.m.Overlay = "active_186";
		}));
	}
});
