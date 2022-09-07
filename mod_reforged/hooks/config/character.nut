::Const.CharacterProperties.PositiveMoraleCheckBravery <- [];
::Const.CharacterProperties.PositiveMoraleCheckBraveryMult <- [];
::Const.CharacterProperties.NegativeMoraleCheckBravery <- [];
::Const.CharacterProperties.NegativeMoraleCheckBraveryMult <- [];

foreach (moraleCheckType in ::Const.MoraleCheckType)
{
	::Const.CharacterProperties.PositiveMoraleCheckBravery.push(0);
	::Const.CharacterProperties.PositiveMoraleCheckBraveryMult.push(1.0);
	::Const.CharacterProperties.NegativeMoraleCheckBravery.push(0);
	::Const.CharacterProperties.NegativeMoraleCheckBraveryMult.push(1.0);
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

local getMeleeSkill = ::Const.CharacterProperties.getMeleeSkill;
::Const.CharacterProperties.getMeleeSkill = function()
{
	return getMeleeSkill() + ::Math.min(0, this.getVision() - 7) * 2;
}

local getRangedSkill = ::Const.CharacterProperties.getRangedSkill;
::Const.CharacterProperties.getRangedSkill = function()
{
	return getRangedSkill() + ::Math.min(0, this.getVision() - 7) * 2;
}

local getMeleeDefense = ::Const.CharacterProperties.getMeleeDefense;
::Const.CharacterProperties.getMeleeDefense = function()
{
	return getMeleeDefense() + ::Math.min(0, this.getVision() - 7) * 2;
}

local getRangedDefense = ::Const.CharacterProperties.getRangedDefense;
::Const.CharacterProperties.getRangedDefense = function()
{
	return getRangedDefense() + ::Math.min(0, this.getVision() - 7) * 2;
}

::Const.ProjectileType.FlamingArrow <- ::Const.ProjectileType.COUNT;
::Const.ProjectileType.COUNT += 1;
::Const.ProjectileDecals.push(clone ::Const.ProjectileDecals[::Const.ProjectileType.Arrow]);
::Const.ProjectileSprite.push("rf_projectile_flaming_arrow");

::Const.Movement.AutoEndTurnBelowAP = 1;
