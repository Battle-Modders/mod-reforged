::mods_hookExactClass("items/weapons/named/named_handgonne", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/handgonne";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		local reload = ::MSU.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
			o.m.FatigueCost += 2;
		});
		this.addSkill(reload);
	}
});
