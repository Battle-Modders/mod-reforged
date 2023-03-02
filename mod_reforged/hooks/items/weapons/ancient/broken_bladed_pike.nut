::mods_hookExactClass("items/weapons/ancient/broken_bladed_pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/impale", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_54.png";
			o.m.IconDisabled = "skills/active_54_sw.png";
			o.m.Overlay = "active_54";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
