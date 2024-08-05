::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spear", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/fighting_spear";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/thrust"));

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall"));
	}
});
