::Const.CharacterProperties.PositiveMoraleCheckBravery <- array(::Const.MoraleCheckType.len(), 0);
::Const.CharacterProperties.PositiveMoraleCheckBraveryMult <- array(::Const.MoraleCheckType.len(), 1.0);
::Const.CharacterProperties.NegativeMoraleCheckBravery <- array(::Const.MoraleCheckType.len(), 0);
::Const.CharacterProperties.NegativeMoraleCheckBraveryMult <- array(::Const.MoraleCheckType.len(), 1.0);

::Const.CharacterProperties.getFatigueRecovery <- function()
{
	return ::Math.floor(this.FatigueRecoveryRate * this.FatigueRecoveryRateMult);
}

local getClone = ::Const.CharacterProperties.getClone;
::Const.CharacterProperties.getClone = function()
{
	local ret = getClone();
	ret.PositiveMoraleCheckBravery = clone this.PositiveMoraleCheckBravery;
	ret.PositiveMoraleCheckBraveryMult = clone this.PositiveMoraleCheckBraveryMult;
	ret.NegativeMoraleCheckBravery = clone this.NegativeMoraleCheckBravery;
	ret.NegativeMoraleCheckBraveryMult = clone this.NegativeMoraleCheckBraveryMult;
	return ret;
}

::Const.CharacterProperties.Reach <- 0;
::Const.CharacterProperties.ReachMult <- 1.0;
::Const.CharacterProperties.getReach <- function()
{
	return ::Math.floor(this.Reach * this.ReachMult);
}
::Const.CharacterProperties.IsAffectedByReach <- true;
::Const.CharacterProperties.DefensiveReachIgnore <- 0;
::Const.CharacterProperties.OffensiveReachIgnore <- 0;
::Const.CharacterProperties.BonusPerReachAdvantage <- 0;

::Const.ProjectileType.FlamingArrow <- ::Const.ProjectileType.COUNT;
::Const.ProjectileType.COUNT += 1;
::Const.ProjectileDecals.push(clone ::Const.ProjectileDecals[::Const.ProjectileType.Arrow]);
::Const.ProjectileSprite.push("rf_projectile_flaming_arrow");

::Const.Movement.AutoEndTurnBelowAP = 1;
