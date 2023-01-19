::mods_hookExactClass("items/weapons/butchers_cleaver", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_68.png";
			o.m.IconDisabled = "skills/active_68_sw.png";
			o.m.Overlay = "active_68";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/gash_skill", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
