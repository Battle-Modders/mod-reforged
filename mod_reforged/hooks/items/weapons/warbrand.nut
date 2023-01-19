::mods_hookExactClass("items/weapons/warbrand", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split", function(o) {
			o.m.FatigueCost -= 10;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/swing", function(o) {
			o.m.FatigueCost -= 10;
		}));
	}
});
