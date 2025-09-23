::Reforged.HooksMod.hook("scripts/skills/actives/throw_acid_flask", function(q) {
// New Functions
	// Our slingItemSkill mechanic (see inherit_helper.nut) requires those thrown object skills to contain an onApply function
	// That is true for many throw item skills, except throw_acid_flask, so we introduce that function here and redirect it to the onApplyAcid function
	q.onApply <- function( _data )
	{
		return this.onApplyAcid(_data);
	}
});
