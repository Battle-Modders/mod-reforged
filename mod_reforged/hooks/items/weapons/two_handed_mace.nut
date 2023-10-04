::Reforged.HooksMod.hook("scripts/items/weapons/two_handed_mace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.ShieldDamage = 22;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cudgel_skill", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_131.png";
			o.m.IconDisabled = "skills/active_131_sw.png";
			o.m.Overlay = "active_131";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/strike_down_skill", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_132.png";
			o.m.IconDisabled = "skills/active_132_sw.png";
			o.m.Overlay = "active_132";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 2;
		}));
	}
});
