::Reforged.HooksMod.hook("scripts/items/weapons/two_handed_flanged_mace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.ShieldDamage = 32;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cudgel_skill", function(o) {
			o.m.Icon = "skills/active_133.png";
			o.m.IconDisabled = "skills/active_133_sw.png";
			o.m.Overlay = "active_133";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/strike_down_skill", function(o) {
			o.m.Icon = "skills/active_134.png";
			o.m.IconDisabled = "skills/active_134_sw.png";
			o.m.Overlay = "active_134";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
