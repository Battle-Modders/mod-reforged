::mods_hookExactClass("items/weapons/greenskins/goblin_pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 7;
		this.m.FlipIconX = true;
		this.m.FlipIconLargeX = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rupture", function(o) {
			o.m.Icon = "skills/active_80.png";
			o.m.IconDisabled = "skills/active_80_sw.png";
			o.m.Overlay = "active_80";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
