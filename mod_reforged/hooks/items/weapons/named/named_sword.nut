::mods_hookExactClass("items/weapons/named/named_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/noble_sword";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
