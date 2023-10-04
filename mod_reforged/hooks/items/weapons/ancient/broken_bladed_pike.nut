::Reforged.HooksMod.hook("scripts/items/weapons/ancient/broken_bladed_pike", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/impale", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_54.png";
			o.m.IconDisabled = "skills/active_54_sw.png";
			o.m.Overlay = "active_54";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
