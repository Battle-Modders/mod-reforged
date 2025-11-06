this.rf_great_cleave_skill <- ::inherit("scripts/skills/actives/cleave", {
	m = {},
	function create()
	{
		this.cleave.create();
		this.m.ID = "actives.rf_great_cleave";
		this.m.Name = "Great Cleave";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A large overhead cleaving attack that can inflict [bleeding|Skill+bleeding_effect] wounds if there is no armor absorbing the blow and if the target is able to bleed at all.");
		this.m.Icon = "skills/rf_great_cleave_skill.png";
		this.m.IconDisabled = "skills/rf_great_cleave_skill_sw.png";
		this.m.Overlay = "rf_great_cleave_skill";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.AttackDefault;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 66;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}
});
