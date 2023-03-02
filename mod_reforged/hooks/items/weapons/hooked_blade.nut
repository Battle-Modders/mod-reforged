::mods_hookExactClass("items/weapons/hooked_blade", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/strike_skill", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_93.png";
			o.m.IconDisabled = "skills/active_93_sw.png";
			o.m.Overlay = "active_93";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/hook", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
