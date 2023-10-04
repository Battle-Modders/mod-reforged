::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_falchion", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.65;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.05;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_78.png";
			o.m.IconDisabled = "skills/active_78_sw.png";
			o.m.Overlay = "active_78";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
