::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_knight_bodyguard", function(q) {
	q.onInit = @() function()
	{
	    this.zombie_knight.onInit();
		// local b = this.m.BaseProperties;
		// b.IsSpecializedInShields = true;

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	}
});
