::mods_hookExactClass("items/weapons/warhammer", function(o) {
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
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
