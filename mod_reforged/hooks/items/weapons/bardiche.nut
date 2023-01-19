::mods_hookExactClass("items/weapons/bardiche", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.FatigueCost += 3;
			o.m.Icon = "skills/active_168.png";
			o.m.IconDisabled = "skills/active_168_sw.png";
			o.m.Overlay = "active_168";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_axe"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 10;
			o.setApplyAxeMastery(true);
		}));
	}
});
