this.perk_rf_double_strike <- ::inherit("scripts/skills/skill", {
	m = {
		IsInEffect = false
		DamageBonus = 20
	},
	function create()
	{
		this.m.ID = "perk.rf_double_strike";
		this.m.Name = ::Const.Strings.PerkName.RF_DoubleStrike;
		this.m.Description = "Having just landed a hit, this character is ready to perform a powerful followup strike! The next attack will inflict more damage. If the attack misses, the effect is wasted.";
		this.m.Icon = "ui/perks/perk_rf_double_strike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Single target attacks deal " + ::MSU.Text.colorizeValue(this.m.DamageBonus, {AddSign = true, AddPercent = true}) + " more damage"
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will be lost upon moving, swapping an item, using any skill except a single-target attack, missing an attack, or [waiting|Concept.Wait] or ending the [turn|Concept.Turn]")
		});

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsInEffect && this.isSkillValid(_skill))
		{
			_properties.MeleeDamageMult *= 1.0 + this.m.DamageBonus * 0.01;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.IsInEffect = this.isSkillValid(_skill);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.IsInEffect = false;
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
	}

	function onWaitTurn()
	{
		this.m.IsInEffect = false;
	}

	function onTurnStart()
	{
		this.m.IsInEffect = false;
	}

	function onResumeTurn()
	{
		this.m.IsInEffect = false;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsInEffect = false;
	}

	function onMovementFinished()
	{
		this.m.IsInEffect = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsInEffect = false;
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && !_skill.isRanged() && !_skill.isAOE();
	}
});
