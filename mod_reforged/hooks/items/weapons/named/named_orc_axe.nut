::Reforged.HooksMod.hook("scripts/items/weapons/named/named_orc_axe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/orc_axe";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/chop"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}
});
