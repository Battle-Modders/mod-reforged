::mods_hookExactClass("ai/tactical/behaviors/ai_charge", function (o) {
	// The purpose of this skill is to allow the `ai_charge.nut` and `ai_engage_melee.nut` vanilla behaviors to be used for Lunge AI.
	// It adds a dummy skill that works like the charge skill i.e. it is used on empty tiles adjacent to an enemy
	// If it is usable then it allows the `ai_engage_melee.nut` behavior to tell the entity to carefully position themselves to engage with a Lunge
	// instead of walking straight into the face of an enemy.
	o.m.PossibleSkills.push("actives.rf_lunge_charge_dummy");
});
