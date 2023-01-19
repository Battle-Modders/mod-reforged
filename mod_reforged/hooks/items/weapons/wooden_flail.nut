::mods_hookExactClass("items/weapons/wooden_flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 2;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/flail_skill", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_62.png";
			o.m.IconDisabled = "skills/active_62_sw.png";
			o.m.Overlay = "active_62";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lash_skill", function(o) {
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_94.png";
			o.m.IconDisabled = "skills/active_94_sw.png";
			o.m.Overlay = "active_94";
		}));
	}
});
