::mods_hookExactClass("items/weapons/named/named_shamshir", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/shamshir";
		create();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.Icon = "skills/active_172.png";
			o.m.IconDisabled = "skills/active_172_sw.png";
			o.m.Overlay = "active_172";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/gash_skill"));
	}
});
