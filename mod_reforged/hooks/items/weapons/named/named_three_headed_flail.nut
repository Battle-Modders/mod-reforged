::mods_hookExactClass("items/weapons/named/named_three_headed_flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/three_headed_flail";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/hail_skill", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
