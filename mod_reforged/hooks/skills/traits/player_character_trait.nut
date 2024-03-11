::Reforged.HooksMod.hook("scripts/skills/traits/player_character_trait", function(q) {
	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.DailyCostMult = 0.0;	// In Vanilla this property of player trait was controlled in the character_background.nut
	}
});
