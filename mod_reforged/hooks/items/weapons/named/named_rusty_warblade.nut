::mods_hookExactClass("items/weapons/named/named_rusty_warblade", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/barbarians/rusty_warblade";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 6;
			o.m.Icon = "skills/active_182.png";
			o.m.IconDisabled = "skills/active_182_sw.png";
			o.m.Overlay = "active_182";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost += 5;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 10;
		}));
	}
});
