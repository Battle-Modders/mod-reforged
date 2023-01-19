::mods_hookExactClass("items/weapons/named/named_two_handed_flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/two_handed_flail";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/pound", function(o) {
			o.m.FatigueCost += 3;
			o.m.Icon = "skills/active_129.png";
			o.m.IconDisabled = "skills/active_129_sw.png";
			o.m.Overlay = "active_129";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/thresh", function(o) {
			o.m.Icon = "skills/active_130.png";
			o.m.IconDisabled = "skills/active_130_sw.png";
			o.m.Overlay = "active_130";
		}));
	}
});
