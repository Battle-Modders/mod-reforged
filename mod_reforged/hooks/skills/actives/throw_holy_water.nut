::Reforged.HooksMod.hook("scripts/skills/actives/throw_holy_water", function(q) {
// New Functions
	// Our slingItemSkill mechanic (see inherit_helper.nut) requires those thrown object skills to contain an onApply function
	// That is true for many throw item skills, except throw_holy_water, so we introduce that function here and redirect it to the onApplyEffect function
	q.onApply <- function( _data )
	{
		return this.onApplyEffect(_data);
	}
});
