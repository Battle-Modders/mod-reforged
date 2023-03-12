::mods_hookExactClass("items/weapons/goedendag", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust", function(o) {
			o.m.Icon = "skills/active_128.png";
			o.m.IconDisabled = "skills/active_128_sw.png";
			o.m.Overlay = "active_128";
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/cudgel_skill", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.DirectDamageMult = this.m.DirectDamageMult;
		}.bindenv(this)));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.Icon = "skills/active_127.png";
			o.m.IconDisabled = "skills/active_127_sw.png";
			o.m.Overlay = "active_127";
			o.m.ActionPointCost -= 1;
		}));
	}
});
