::mods_hookExactClass("items/weapons/ancient/ancient_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
		this.m.FlipIconX = true;
		this.m.FlipIconY = true;
		this.m.FlipIconLargeX = true;
		this.m.FlipIconLargeY = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
