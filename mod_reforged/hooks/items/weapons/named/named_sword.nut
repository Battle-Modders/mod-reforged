::Reforged.HooksMod.hook("scripts/items/weapons/named/named_sword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/noble_sword";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
