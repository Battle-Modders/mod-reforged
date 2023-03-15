::mods_hookExactClass("skills/actives/coat_with_poison_skill", function(o) {
	local onAfterUpdate = "onAfterUpdate" in o ? o.onAfterUpdate : null;
	o.onAfterUpdate <- function( _properties )
	{
		if (onAfterUpdate != null) onAfterUpdate(_properties);
		if (::Time.getRound() == 1) this.m.ActionPointCost = 0;
	}
});
