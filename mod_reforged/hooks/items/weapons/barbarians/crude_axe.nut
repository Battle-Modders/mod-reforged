::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/crude_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.ShieldDamage = 16;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.Icon = "skills/active_185.png";
			o.m.IconDisabled = "skills/active_185_sw.png";
			o.m.Overlay = "active_185";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
