::mods_hookExactClass("items/weapons/named/named_warhammer", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/warhammer";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/hammer"));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor"));
	}
});
