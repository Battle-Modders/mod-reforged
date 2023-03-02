::mods_hookExactClass("items/weapons/pitchfork", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -6;
		this.m.Reach = 6;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/impale", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_57.png";
			o.m.IconDisabled = "skills/active_57_sw.png";
			o.m.Overlay = "active_57";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_58.png";
			o.m.IconDisabled = "skills/active_58_sw.png";
			o.m.Overlay = "active_58";
		}));
	}
});
