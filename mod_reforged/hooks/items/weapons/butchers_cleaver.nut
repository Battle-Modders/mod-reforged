::Reforged.HooksMod.hook("scripts/items/weapons/butchers_cleaver", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_68.png";
			o.m.IconDisabled = "skills/active_68_sw.png";
			o.m.Overlay = "active_68";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/gash_skill", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}
});
