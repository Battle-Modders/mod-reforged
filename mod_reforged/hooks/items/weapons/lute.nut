::Reforged.HooksMod.hook("scripts/items/weapons/lute", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 2;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 10;
			o.m.IsFromLute = true;
			o.m.Icon = "skills/active_88.png";
			o.m.IconDisabled = "skills/active_88_sw.png";
			o.m.Overlay = "active_88";
		}));
	}
});
