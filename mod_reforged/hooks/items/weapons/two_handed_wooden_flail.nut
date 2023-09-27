::Reforged.HooksMod.hook("scripts/items/weapons/two_handed_wooden_flail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/pound", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_129.png";
			o.m.IconDisabled = "skills/active_129_sw.png";
			o.m.Overlay = "active_129";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/thresh", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_130.png";
			o.m.IconDisabled = "skills/active_130_sw.png";
			o.m.Overlay = "active_130";
		}));
	}
});
