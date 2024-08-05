::Reforged.HooksMod.hook("scripts/items/weapons/named/named_three_headed_flail", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/three_headed_flail";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/hail_skill"));
	}
});
