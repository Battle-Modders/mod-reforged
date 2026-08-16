this.rf_perforate_sword_thrust_skill <- ::inherit("scripts/skills/actives/rf_sword_thrust_skill", {
	m = {
		MeleeSkillAdd = -10
	},
	function create()
	{
		this.rf_sword_thrust_skill.create();
		this.m.ID = "actives.rf_perforate_sword_thrust";
		this.m.Name = "Perforate thrust";
		// hidden and only used as part of perforate
		this.m.IsHidden = true;
        this.m.KilledString = "Turned into a pincushion";
		this.m.SoundOnUse = [];
		this.m.SoundOnHit = [
			"sounds/combat/perforate_attack_hit_01.wav",
			"sounds/combat/perforate_attack_hit_02.wav",
			"sounds/combat/perforate_attack_hit_03.wav",
			"sounds/combat/perforate_attack_hit_04.wav"
		];
	}
});
