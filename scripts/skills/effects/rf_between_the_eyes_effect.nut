this.rf_between_the_eyes_effect <- ::inherit("scripts/skills/skill", {
	m = {
		MeleeSkillToHeadshotChancePct = 0.5
		HeadshotDamageMult = 1.5
	},
	function create()
	{
		this.m.ID = "effects.rf_between_the_eyes";
		this.m.Name = "Between the Eyes";
		this.m.Description = "This character is prepared to land his next attack right between the target\'s eyes.";
		this.m.Icon = "ui/perks//perk_rf_between_the_eyes.png";
		this.m.Overlay = "rf_between_the_eyes_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local chanceStr;
		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			chanceStr = "chance equal to " + ::MSU.Text.colorizePct(this.m.MeleeSkillToHeadshotChancePct) + " of [Melee Skill|Concept.MeleeSkill]"
		}
		else
		{
			chanceStr = ::MSU.Text.colorizeValue(this.getHeadshotChanceAdd(), {AddSign = true, AddPercent = true}) + " chance"
		}
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next melee attack has a " + chanceStr + " to hit the head and deals " + ::MSU.Text.colorizeMult(this.m.HeadshotDamageMult) + " damage on a such a hit")
		});

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isSkillValid(_skill))
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.getHeadshotChanceAdd();
			_properties.DamageAgainstMult[::Const.BodyPart.Head] *= this.getHeadshotDamageMult();
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeSelf();
	}

	function getHeadshotChanceAdd()
	{
		return ::Math.max(0, this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * this.m.MeleeSkillToHeadshotChancePct);
	}

	function getHeadshotDamageMult()
	{
		return this.m.HeadshotDamageMult;
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && !_skill.isRanged();
	}
});
