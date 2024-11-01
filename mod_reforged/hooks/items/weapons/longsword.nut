
::Reforged.HooksMod.hook("scripts/items/weapons/longsword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 75;
		this.m.DirectDamageMult = 0.3;
		this.m.ArmorDamageMult = 0.8;
		this.m.StaminaModifier = -10;
		this.m.ChanceToHitHead = 10;
		this.m.Value = 2400;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		local self = this;
		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 3;
			o.m.DirectDamageMult = self.m.DirectDamageMult;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/overhead_strike", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.DirectDamageMult = self.m.DirectDamageMult;
			o.setStunChance(self.m.StunChance);
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte"));
	}
});
