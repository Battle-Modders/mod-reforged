::Reforged.HooksMod.hook("scripts/items/weapons/exesword", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.Value = 1200;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
		this.m.AdditionalAccuracy = -15;
		this.m.ChanceToHitHead = 0;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_heavy_cleave_skill", function(o) {
			o.m.Icon = "skills/active_19.png";
			o.m.IconDisabled = "skills/active_19_sw.png";
			o.m.Overlay = "active_19";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/exesword_decapitate"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}}.onEquip;
});
