::Reforged.HooksMod.hook("scripts/items/weapons/warfork", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
		 // Vanilla 400. Increased due to attacking twice with perk in Reforged.
		this.m.Value = 600;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		local prong = ::Reforged.new("scripts/skills/actives/prong_skill", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_174.png";
			o.m.IconDisabled = "skills/active_174_sw.png";
			o.m.Overlay = "active_174";
		});

		this.addSkill(prong);

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.Icon = "skills/active_173.png";
			o.m.IconDisabled = "skills/active_173_sw.png";
			o.m.Overlay = "active_173";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
