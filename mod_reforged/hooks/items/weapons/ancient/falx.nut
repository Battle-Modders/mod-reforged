::mods_hookExactClass("items/weapons/ancient/falx", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 2;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
