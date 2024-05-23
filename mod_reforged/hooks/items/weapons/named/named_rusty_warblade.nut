::Reforged.HooksMod.hook("scripts/items/weapons/named/named_rusty_warblade", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/barbarians/rusty_warblade";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rf_great_cleave_skill", function(o) {
			o.m.Icon = "skills/active_182.png";
			o.m.IconDisabled = "skills/active_182_sw.png";
			o.m.Overlay = "active_182";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.ActionPointCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}
});
