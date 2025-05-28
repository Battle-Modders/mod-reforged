::Reforged.HooksMod.hook("scripts/items/weapons/spetum", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 6;
		 // Vanilla 750 where it is comparable to Hooked Blade in value and damage output. Increased due to attacking twice with perk in Reforged.
		this.m.Value = 1050;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		local prong = ::new("scripts/skills/actives/prong_skill");

		this.addSkill(prong);

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}}.onEquip;
});
