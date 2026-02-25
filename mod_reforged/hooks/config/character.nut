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
	RF_BleedingEffectMult = 1.0

	function getReach()
	{
		return ::Math.floor(this.Reach * this.ReachMult);
	}

	function getFatigueRecoveryRate()
	{
		return ::Math.floor(this.FatigueRecoveryRate * this.FatigueRecoveryRateMult);
	}

	function getClone()
	{
		local ret = original_getClone();
		ret.PositiveMoraleCheckBravery = clone this.PositiveMoraleCheckBravery;
		ret.PositiveMoraleCheckBraveryMult = clone this.PositiveMoraleCheckBraveryMult;
		ret.NegativeMoraleCheckBravery = clone this.NegativeMoraleCheckBravery;
		ret.NegativeMoraleCheckBraveryMult = clone this.NegativeMoraleCheckBraveryMult;
		return ret;
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
