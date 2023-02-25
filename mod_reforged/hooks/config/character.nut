::Const.CharacterProperties.PositiveMoraleCheckBravery <- [];
::Const.CharacterProperties.PositiveMoraleCheckBraveryMult <- [];
::Const.CharacterProperties.NegativeMoraleCheckBravery <- [];
::Const.CharacterProperties.NegativeMoraleCheckBraveryMult <- [];

::Const.CharacterProperties.Weight <- [
	0.0,	// Mainhand
	0.0,	// Offhand
	0.0,	// Body
	0.0,	// Head
	0.0,	// Accessory
	0.0,	// Ammo
	0.0		// Bag
]

::Const.CharacterProperties.WeightMult <- [
	1.0,	// Mainhand
	1.0,	// Offhand
	1.0,	// Body
	1.0,	// Head
	1.0,	// Accessory
	1.0,	// Ammo
	0.5		// Bag - We apply the fatigue reduction for bags here at this point instead of in 'bag_fatigue.nut'
]

::Const.CharacterProperties.BurdenMult <- [
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
	local initiativeMult = (this.Initiative >= 0) ? this.InitiativeMult : (1 / this.InitiativeMult);	// Vanilla does this line wrong so essentially this never works for vanilla
	return ::Math.floor(this.Initiative * initiativeMult);	// Vanilla does a round here instead of floor
}

// New function for gaining the correct Stamina before weight reductions
::Const.CharacterProperties.getStamina <- function()
{
	// A negative Stamina should get worse from a positive StaminaMult, so we reverse the effect of the StaminaMult in this case
	local staminaMult = (this.Stamina >= 0) ? this.StaminaMult : (1 / this.StaminaMult);
	return ::Math.floor(this.Stamina * staminaMult);
}

// Returns the raw combined weight for all passed itemslots on this character.
// These will be filled during SkillOrder.Item which is 1000. You can only expect this to return something other than 0 if your skill has a higher order
// _itemSlots is an array of all the itemSlots that you want the combined weight for. An empty array means you want the weight of everything
::Const.CharacterProperties.getRawWeight <- function(_itemSlots = [])
{
	local combinedWeight = 0;
	if (_itemSlots.len() == 0)
	{
		foreach(weight in this.Weight)
		{
			combinedWeight += weight;
		}
	}
	else
	{
		foreach(itemSlot in _itemSlots)
		{
			combinedWeight += this.Weight[itemSlot];
		}
	}
	return combinedWeight;
}

// Returns the actual applied weight for all passed itemslots on this character.
// This will be incorrect if called before SkillOrder.Perk which is where perks like Brawny or BagsAndBelts manipulate the weight-multipliers
// _itemSlots is an array of all the itemSlots that you want the combined weight for. An empty array means you want the weight of everything
::Const.CharacterProperties.getWeight <- function(_itemSlots = [])
{
	local combinedWeight = 0;
	if (_itemSlots.len() == 0)
	{
		foreach(key, weight in this.Weight)
		{
			combinedWeight += weight * this.WeightMult[key];
		}
	}
	else
	{
		foreach(itemSlot in _itemSlots)
		{
			combinedWeight += this.Weight[itemSlot] * this.WeightMult[itemSlot];
		}
	}
	return ::Math.ceil(combinedWeight);
}

// Returns the initiative penalty (called 'Burden' here) for all passed itemslots on this character.
// This will be incorrect if called before SkillOrder.Perk which is where perks like Brawny or BagsAndBelts manipulate the weight-multipliers
// _itemSlots is an array of all the itemSlots that you want the combined burden for. An empty array means you want the weight of everything
::Const.CharacterProperties.getBurden <- function(_itemSlots = [])
{
	local combinedBurden = 0;
	if (_itemSlots.len() == 0)
	{
		foreach(key, weight in this.Weight)
		{
			combinedBurden += weight * this.WeightMult[key] * this.BurdenMult[key];
		}
	}
	else
	{
		foreach(itemSlot in _itemSlots)
		{
			combinedBurden += this.Weight[itemSlot] * this.WeightMult[itemSlot] * this.BurdenMult[itemSlot];
		}
	}
	return ::Math.ceil(combinedBurden);
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
	ret.Weight = clone this.Weight;
	ret.WeightMult = clone this.WeightMult;
	ret.BurdenMult = clone this.BurdenMult;
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
