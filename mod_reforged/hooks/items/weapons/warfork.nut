::mods_hookExactClass("items/weapons/warfork", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
		this.m.FlipIconX = true;
		this.m.FlipIconLargeX = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		local prong = ::MSU.new("scripts/skills/actives/prong_skill", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_174.png";
			o.m.IconDisabled = "skills/active_174_sw.png";
			o.m.Overlay = "active_174";
		});

		this.addSkill(prong);

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost -= 6;
			o.m.Icon = "skills/active_173.png";
			o.m.IconDisabled = "skills/active_173_sw.png";
			o.m.Overlay = "active_173";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
