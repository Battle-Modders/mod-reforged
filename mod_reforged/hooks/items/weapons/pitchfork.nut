::Reforged.HooksMod.hook("scripts/items/weapons/pitchfork", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -10; // vanilla -14
		this.m.Reach = 6;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/impale", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_57.png";
			o.m.IconDisabled = "skills/active_57_sw.png";
			o.m.Overlay = "active_57";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/repel", function(o) {
			o.m.FatigueCost -= 5;
			o.m.Icon = "skills/active_58.png";
			o.m.IconDisabled = "skills/active_58_sw.png";
			o.m.Overlay = "active_58";
		}));
	}
});
