::Reforged.HooksMod.hook("scripts/items/weapons/named/named_mace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/winged_mace";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/bash"));

		this.addSkill(::Reforged.new("scripts/skills/actives/knock_out"));
	}
});
