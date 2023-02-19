::mods_hookExactClass("items/weapons/crossbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		local reload = ::MSU.new("scripts/skills/actives/reload_bolt");
		reload.m.IsHidden = this.m.IsLoaded;
		this.addSkill(reload);
	}
});
