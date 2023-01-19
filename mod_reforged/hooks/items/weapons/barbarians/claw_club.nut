::mods_hookExactClass("items/weapons/barbarians/claw_club", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_183.png";
			o.m.IconDisabled = "skills/active_183_sw.png";
			o.m.Overlay = "active_183";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_186.png";
			o.m.IconDisabled = "skills/active_186_sw.png";
			o.m.Overlay = "active_186";
		}));
	}
});
