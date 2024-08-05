::Reforged.HooksMod.hook("scripts/items/weapons/hooked_blade", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/strike_skill", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_93.png";
			o.m.IconDisabled = "skills/active_93_sw.png";
			o.m.Overlay = "active_93";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/hook", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
