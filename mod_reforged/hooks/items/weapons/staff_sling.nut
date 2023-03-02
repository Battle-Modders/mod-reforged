::mods_hookExactClass("items/weapons/staff_sling", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
		this.addWeaponType(::Const.Items.WeaponType.Sling);
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/sling_stone_skill", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
