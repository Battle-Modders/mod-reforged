::mods_hookExactClass("items/weapons/fencing_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ItemType += ::Const.Items.ItemType.RFFencing;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.2;
		this.m.ArmorDamageMult = 0.3;
		this.m.ChanceToHithead = -25;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));
		this.addSkill(::new("scripts/skills/actives/lunge_skill"));
		this.addSkill(::new("scripts/skills/actives/riposte"));
	}
});
