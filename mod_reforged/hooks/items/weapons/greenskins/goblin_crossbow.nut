::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_stake"));

		local reload = ::MSU.new("scripts/skills/actives/reload_bolt");
		this.addSkill(reload);
	}

	::Reforged.Items.makeWeaponLoaded(o);

});
