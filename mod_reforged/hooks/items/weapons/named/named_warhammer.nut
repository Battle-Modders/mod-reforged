::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warhammer", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/warhammer";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer"));

		this.addSkill(::Reforged.new("scripts/skills/actives/crush_armor"));
	}
});
