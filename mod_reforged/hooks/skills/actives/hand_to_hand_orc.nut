::Reforged.HooksMod.hook("scripts/skills/actives/hand_to_hand_orc", function(q) {
	::Reforged.HooksHelper.moveDamageToOnAnySkillUsed(q);
});
