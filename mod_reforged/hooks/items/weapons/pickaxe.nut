::mods_hookExactClass("items/weapons/pickaxe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/hammer", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_60.png";
			o.m.IconDisabled = "skills/active_60_sw.png";
			o.m.Overlay = "active_60";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_59.png";
			o.m.IconDisabled = "skills/active_59_sw.png";
			o.m.Overlay = "active_59";
		}));
	}
});
