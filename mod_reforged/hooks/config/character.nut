::Const.CharacterProperties.PositiveMoraleCheckBravery <- [];
::Const.CharacterProperties.PositiveMoraleCheckBraveryMult <- [];
::Const.CharacterProperties.NegativeMoraleCheckBravery <- [];
::Const.CharacterProperties.NegativeMoraleCheckBraveryMult <- [];

::Const.CharacterProperties.StaminaModifierMult <- [
	1.0,	// Mainhand
	1.0,	// Offhand
	1.0,	// Body
	1.0,	// Head
	1.0,	// Accessory
	1.0,	// Ammo
	0.5		// Bag - We apply the fatigue reduction for bags here at this point instead of in 'bag_fatigue.nut'
]

::Const.CharacterProperties.InitiativeModifierMult <- [
	1.0,	// Mainhand
	1.0,	// Offhand
	1.0,	// Body
	1.0,	// Head
	1.0,	// Accessory
	1.0,	// Ammo
	1.0		// Bag
]

// Overwrite of vanilla Initiative Function to fix negative initiative calculation oversight
::Const.CharacterProperties.getInitiative = function()
{
	// A negative Iniative should get worse from a positive InitiativeMult, so we reverse the effect of the InitiativeMult in this case
	local initiativeMult = (this.Initiative >= 0) ? this.InitiativeMult : (1.0 / this.InitiativeMult);	// Vanilla does this line wrong so essentially this never works for vanilla
	return ::Math.floor(this.Initiative * initiativeMult);	// Vanilla does a round here instead of floor
}

// New function for gaining the current Stamina before weight reductions
::Const.CharacterProperties.getStamina <- function()
{
	// A negative Stamina should get worse from a positive StaminaMult, so we reverse the effect of the StaminaMult in this case
	local staminaMult = (this.Stamina >= 0) ? this.StaminaMult : (1.0 / this.StaminaMult);
	return ::Math.floor(this.Stamina * staminaMult);
}

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
	ret.StaminaModifierMult = clone this.StaminaModifierMult;
	ret.InitiativeModifierMult = clone this.InitiativeModifierMult;
	return ret;
}

::Const.CharacterProperties.Reach <- 0;
::Const.CharacterProperties.ReachMult <- 1.0;
::Const.CharacterProperties.getReach <- function()
{
	return ::Math.floor(this.Reach * this.ReachMult);
}
::Const.CharacterProperties.IsAffectedByReach <- true;

::Const.ProjectileType.FlamingArrow <- ::Const.ProjectileType.COUNT;
::Const.ProjectileType.COUNT += 1;
::Const.ProjectileDecals.push(clone ::Const.ProjectileDecals[::Const.ProjectileType.Arrow]);
::Const.ProjectileSprite.push("rf_projectile_flaming_arrow");

::Const.Movement.AutoEndTurnBelowAP = 1;
