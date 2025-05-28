::Reforged.HooksMod.hook("scripts/items/weapons/wooden_flail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.RegularDamage += 5;
		this.m.RegularDamageMax += 5;
		this.m.Reach = 2;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/flail_skill", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_62.png";
			o.m.IconDisabled = "skills/active_62_sw.png";
			o.m.Overlay = "active_62";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/lash_skill", function(o) {
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_94.png";
			o.m.IconDisabled = "skills/active_94_sw.png";
			o.m.Overlay = "active_94";
		}));
	}}.onEquip;
});
