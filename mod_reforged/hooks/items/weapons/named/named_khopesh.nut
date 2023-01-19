::mods_hookExactClass("items/weapons/named/named_khopesh", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/khopesh";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
