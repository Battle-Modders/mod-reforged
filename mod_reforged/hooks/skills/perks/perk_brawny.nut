::mods_hookExactClass("skills/perks/perk_brawny", function (o) {

	o.onUpdate <- function( _properties )
	{
		_properties.StaminaModifierMult[::Const.ItemSlot.Body] *= 0.7;
		_properties.StaminaModifierMult[::Const.ItemSlot.Head] *= 0.7;
	}
});
