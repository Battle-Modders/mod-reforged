::Reforged.HooksMod.hook("scripts/items/weapons/named/named_fencing_sword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/fencing_sword";

	q.onEquip = @() { function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));

		this.addSkill(::new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::new("scripts/skills/actives/riposte"));
	}}.onEquip;
});
