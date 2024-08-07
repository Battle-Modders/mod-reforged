::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_mace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/two_handed_flanged_mace";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cudgel_skill", function(o) {
			o.m.Icon = "skills/active_133.png";
			o.m.IconDisabled = "skills/active_133_sw.png";
			o.m.Overlay = "active_133";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/strike_down_skill", function(o) {
			o.m.Icon = "skills/active_134.png";
			o.m.IconDisabled = "skills/active_134_sw.png";
			o.m.Overlay = "active_134";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
