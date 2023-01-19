::mods_hookExactClass("items/weapons/greenskins/goblin_notched_blade", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_77.png";
			o.m.IconDisabled = "skills/active_77_sw.png";
			o.m.Overlay = "active_77";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/puncture", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
