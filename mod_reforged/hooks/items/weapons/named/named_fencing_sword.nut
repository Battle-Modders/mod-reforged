::Reforged.HooksMod.hook("scripts/items/weapons/named/named_fencing_sword", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fencing_sword";
		__original();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Fencing;
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));

		this.addSkill(::new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::new("scripts/skills/actives/riposte"));
	}
});
