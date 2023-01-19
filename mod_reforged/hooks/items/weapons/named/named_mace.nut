::mods_hookExactClass("items/weapons/named/named_mace", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/winged_mace";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash", function(o) {
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
