::mods_hookExactClass("items/weapons/ancient/khopesh", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
