::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spetum", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/spetum";

	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla 2800. Increased due to attacking twice with perk in Reforged.
		this.m.Value = 3500;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.named_weapon.onEquip();

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
