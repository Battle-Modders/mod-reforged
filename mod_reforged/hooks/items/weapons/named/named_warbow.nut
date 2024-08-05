::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbow", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/war_bow";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/quick_shot"));

		this.addSkill(::Reforged.new("scripts/skills/actives/aimed_shot"));
	}
});
