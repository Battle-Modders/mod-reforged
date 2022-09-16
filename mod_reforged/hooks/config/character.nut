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
