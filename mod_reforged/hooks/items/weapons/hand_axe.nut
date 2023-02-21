::mods_hookExactClass("items/weapons/hand_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
		this.m.ShieldDamage = 22;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true)
		}));
	}
});
