::mods_hookExactClass("items/weapons/oriental/handgonne", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		local reload = ::MSU.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
			o.m.FatigueCost += 2;
		});
		reload.m.IsHidden = this.m.IsLoaded;
		this.addSkill(reload);
	}
});
