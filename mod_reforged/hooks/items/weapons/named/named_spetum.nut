::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spetum", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/spetum";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		local prong = ::MSU.new("scripts/skills/actives/prong_skill");
		this.addSkill(prong);

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
