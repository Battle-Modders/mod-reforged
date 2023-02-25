::mods_hookExactClass("skills/perks/perk_brawny", function (o) {

	o.onUpdate <- function( _properties )
	{
		_properties.WeightMult[::Const.ItemSlot.Body] *= 0.7;
		_properties.WeightMult[::Const.ItemSlot.Head] *= 0.7;
	}
});
