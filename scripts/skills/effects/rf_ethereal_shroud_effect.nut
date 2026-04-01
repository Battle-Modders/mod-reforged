this.rf_ethereal_shroud_effect <- ::inherit("scripts/skills/skill", {
	m = {
		__IsBeingHitInMelee = false
	},
	function create()
	{
		this.m.ID = "effects.rf_ethereal_shroud";
		this.m.Name = "Ethereal Shroud";
		this.m.Description = "A shroud of ethereal mist surrounds this character.";
		this.m.Icon = "skills/rf_ethereal_shroud_effect.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Melee attackers who inflict [Hitpoint|Concept.Hitpoints] damage to you are afflicted with [$ $|Skill+rf_numbness_effect]")
			children = ::new("scripts/skills/effects/rf_numbness_effect").getTooltip().slice(2) // slice 2 to remove name and description
		});
		return ret;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.m.__IsBeingHitInMelee = _skill != null && _skill.isAttack() && !_skill.isRanged() && this.isAttackerValid(_attacker);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints > 0 && this.m.__IsBeingHitInMelee)
		{
			_attacker.getSkills().add(::new("scripts/skills/effects/rf_numbness_effect"));
		}
	}

	function isAttackerValid( _attacker )
	{
		// Invalid are the "Pure" undead units i.e. those who aren't affected by Fatigue.
		// This is because vanil has the "undead" flag even on stuff like ghouls.
		if (_attacker.getFlags().has("undead"))
			return _attacker.getCurrentProperties().FatigueEffectMult != 1.0;

		return true;
	}
});
