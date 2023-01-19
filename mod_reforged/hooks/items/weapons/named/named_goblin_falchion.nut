::mods_hookExactClass("items/weapons/named/named_goblin_falchion", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/goblin_falchion";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_78.png";
			o.m.IconDisabled = "skills/active_78_sw.png";
			o.m.Overlay = "active_78";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
