::Reforged.HooksMod.hook("scripts/items/weapons/longsword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 0.8;
		this.m.StaminaModifier = -8;
		this.m.ChanceToHitHead = 10;
		this.m.Value = 2000;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 2;
			o.m.DirectDamageMult = this.m.DirectDamageMult;
		}.bindenv(this)));

		this.addSkill(::MSU.new("scripts/skills/actives/overhead_strike", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 1;
			o.setStunChance(this.m.StunChance);
		}.bindenv(this)));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
