::mods_hookExactClass("items/weapons/barbarians/heavy_rusty_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.ShieldDamage = 46;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.Icon = "skills/active_187.png";
			o.m.IconDisabled = "skills/active_187_sw.png";
			o.m.Overlay = "active_187";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/round_swing", function(o) {
			o.m.Icon = "skills/active_188.png";
			o.m.IconDisabled = "skills/active_188_sw.png";
			o.m.Overlay = "active_188";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
