::Reforged.HooksMod.hook("scripts/items/weapons/fencing_sword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Fencing;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.2;
		this.m.ArmorDamageMult = 0.3;
		this.m.ChanceToHitHead = -25;
	}

	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));

		this.addSkill(::new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::new("scripts/skills/actives/riposte"));
	}
});
