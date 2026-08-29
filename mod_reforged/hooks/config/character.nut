local original_getClone = ::Const.CharacterProperties.getClone;
::MSU.Table.merge(::Const.CharacterProperties, {
	PositiveMoraleCheckBravery = array(::Const.MoraleCheckType.len(), 0),
	PositiveMoraleCheckBraveryMult = array(::Const.MoraleCheckType.len(), 1.0),
	NegativeMoraleCheckBravery = array(::Const.MoraleCheckType.len(), 0),
	NegativeMoraleCheckBraveryMult =array(::Const.MoraleCheckType.len(), 1.0),
	Reach = 0,
	ReachMult = 1.0,
	IsAffectedByReach = true,
	DefensiveReachIgnore = 0,
	OffensiveReachIgnore = 0,
	BonusPerReachAdvantage = 0,
	RF_BleedingEffectMult = 1.0,

	function getClone()
	{
		local ret = original_getClone();
		ret.PositiveMoraleCheckBravery = clone this.PositiveMoraleCheckBravery;
		ret.PositiveMoraleCheckBraveryMult = clone this.PositiveMoraleCheckBraveryMult;
		ret.NegativeMoraleCheckBravery = clone this.NegativeMoraleCheckBravery;
		ret.NegativeMoraleCheckBraveryMult = clone this.NegativeMoraleCheckBraveryMult;
		return ret;
	}

	function getReach()
	{
		return ::Math.floor(this.Reach * this.ReachMult);
	}

	function getFatigueRecoveryRate()
	{
		return ::Math.floor(this.FatigueRecoveryRate * this.FatigueRecoveryRateMult);
	}

	// In vanilla negative values are always multiplied with (1.0 / mult)
	// This causes mults between 0.0 and 1.0 i.e. those that would reduce a positive value
	// to increase the negative value by double the amount. E.g. a 50% reduction on a positive
	// value becomes a 2x increase on the negative value (in the negative direction).
	// We implement a more intricate system whereby this behavior is only for mults > 1.0.
	// For mults between 0.0 and 1.0 we instead multiply by 2.0 - mult. This results in
	// a 50% reduction on a positive value to be a 50% increase on the negative value
	// in the negative direction. So it behaves more intuitively.
	// Bonus: Also fixes the vanilla edge-case of division by zero when mult is 0.
	function __getValueWithMult( _value, _mult )
	{
		local mult = _value > 0 ? _mult : (_mult > 1.0 ? 1.0 / _mult : 2.0 - _mult);
		// We round to 1 decimal place to avoid floating point precision issues
		// that would result in 120 * 1.05 giving 125.9999 instead of 126 and being
		// floored to 125 instead of giving 126 as the answer.
		return ::Math.floor(::MSU.Math.roundToDec(_value * mult, 1));
	}

	function getMeleeDefense()
	{
		return this.__getValueWithMult(this.MeleeDefense, this.MeleeDefenseMult);
	}

	function getRangedDefense()
	{
		return this.__getValueWithMult(this.RangedDefense, this.RangedDefenseMult);
	}

	function getMeleeSkill()
	{
		return this.__getValueWithMult(this.MeleeSkill, this.MeleeSkillMult);
	}

	function getRangedSkill()
	{
		return this.__getValueWithMult(this.RangedSkill, this.RangedSkillMult);
	}

	function getBravery()
	{
		return this.__getValueWithMult(this.Bravery, this.BraveryMult);
	}

	function getInitiative()
	{
		return this.__getValueWithMult(this.Initiative, this.InitiativeMult);
	}
});


::Const.CharacterProperties.IsImmuneIsOnToEnterPushback <- false;	// Will an enemy spearwall push me back to my original tile when they hit the AOO?
::Const.CharacterProperties.IsSpearwallPushingBack <- false;		// Will my spearwall-like AOO push enemies back that I hit when they try to enter?

::Const.ProjectileType.FlamingArrow <- ::Const.ProjectileType.COUNT;
::Const.ProjectileType.COUNT += 1;
::Const.ProjectileDecals.push(clone ::Const.ProjectileDecals[::Const.ProjectileType.Arrow]);
::Const.ProjectileSprite.push("rf_projectile_flaming_arrow");

::Const.Movement.AutoEndTurnBelowAP = 1;

::Const.Morale.RF_AllyFleeingBraveryModifierPerAlly <- 1;

::Const.RF_ActionPointsStateName <- [
	"Spent",
	"Slowing Down",
	"Measured",
	"Primed"
];
