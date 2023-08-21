::mods_hookExactClass("items/weapons/greatsword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Zweihander";
		this.m.Reach = 7;
		this.m.ShieldDamage = 24;
		this.m.FlipIconY = true;
		this.m.FlipIconLargeY = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/overhead_strike"));

		this.addSkill(::MSU.new("scripts/skills/actives/split"));

		this.addSkill(::MSU.new("scripts/skills/actives/swing"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
