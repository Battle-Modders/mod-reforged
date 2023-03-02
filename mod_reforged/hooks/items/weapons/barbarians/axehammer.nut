::mods_hookExactClass("items/weapons/barbarians/axehammer", function(o) {
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

		this.addSkill(::MSU.new("scripts/skills/actives/hammer", function(o) {
			o.m.Icon = "skills/active_184.png";
			o.m.IconDisabled = "skills/active_184_sw.png";
			o.m.Overlay = "active_184";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
