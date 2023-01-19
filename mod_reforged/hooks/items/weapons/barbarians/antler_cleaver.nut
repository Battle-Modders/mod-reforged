::mods_hookExactClass("items/weapons/barbarians/antler_cleaver", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_177.png";
			o.m.IconDisabled = "skills/active_177_sw.png";
			o.m.Overlay = "active_177";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
