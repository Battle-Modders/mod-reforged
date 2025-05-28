::Reforged.HooksMod.hook("scripts/items/weapons/lute", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.IsDoubleGrippable = false;	// VanillaFix: Vanilla has set to true, allowing this weapon to be double gripped, even though it already is two-handed
		this.m.Reach = 2;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out", function(o) {
			o.m.FatigueCost -= 10;
			o.m.IsFromLute = true;
			o.m.Icon = "skills/active_88.png";
			o.m.IconDisabled = "skills/active_88_sw.png";
			o.m.Overlay = "active_88";
		}));
	}}.onEquip;
});
