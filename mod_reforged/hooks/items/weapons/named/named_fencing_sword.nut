::mods_hookExactClass("items/weapons/named/named_fencing_sword", function(o) {
	o.m.BaseWeaponScript = "scripts/items/weapons/fencing_sword";

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));
		this.addSkill(::new("scripts/skills/actives/lunge_skill"));
		this.addSkill(::new("scripts/skills/actives/riposte"));
	}
});
