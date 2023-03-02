::mods_hookExactClass("items/weapons/named/named_spear", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fighting_spear";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust"));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall"));
	}
});
