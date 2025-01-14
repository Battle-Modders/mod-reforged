::Reforged.HooksMod.hook("scripts/items/weapons/spetum", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		local prong = ::Reforged.new("scripts/skills/actives/prong_skill", function(o) {
			o.m.ActionPointCost -= 1;
		});

		this.addSkill(prong);

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
