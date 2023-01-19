::mods_hookExactClass("items/weapons/barbarians/rusty_warblade", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 6;
			o.m.Icon = "skills/active_182.png";
			o.m.IconDisabled = "skills/active_182_sw.png";
			o.m.Overlay = "active_182";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost += 5;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 10;
		}));
	}
});
