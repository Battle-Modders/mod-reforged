::Reforged.HooksMod.hook("scripts/items/weapons/ancient/falx", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 2;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
