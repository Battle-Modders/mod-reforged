::Reforged.HooksMod.hook("scripts/items/weapons/morning_star", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_76.png";
			o.m.IconDisabled = "skills/active_76_sw.png";
			o.m.Overlay = "active_76";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
