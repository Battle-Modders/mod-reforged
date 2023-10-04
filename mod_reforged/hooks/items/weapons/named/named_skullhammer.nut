::Reforged.HooksMod.hook("scripts/items/weapons/named/named_skullhammer", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/barbarians/skull_hammer";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/smite_skill", function(o) {
			o.m.Icon = "skills/active_180.png";
			o.m.IconDisabled = "skills/active_180_sw.png";
			o.m.Overlay = "active_180";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/shatter_skill", function(o) {
			o.m.Icon = "skills/active_181.png";
			o.m.IconDisabled = "skills/active_181_sw.png";
			o.m.Overlay = "active_181";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
