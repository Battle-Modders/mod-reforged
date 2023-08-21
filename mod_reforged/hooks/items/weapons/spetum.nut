::mods_hookExactClass("items/weapons/spetum", function(o) {
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

		local prong = ::MSU.new("scripts/skills/actives/prong_skill");
		this.addSkill(prong);

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
