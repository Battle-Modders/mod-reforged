::mods_hookExactClass("items/weapons/named/named_fencing_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fencing_sword";
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Fencing;
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_sword_thrust_skill"));

		this.addSkill(::new("scripts/skills/actives/lunge_skill"));

		this.addSkill(::new("scripts/skills/actives/riposte"));
	}
});
