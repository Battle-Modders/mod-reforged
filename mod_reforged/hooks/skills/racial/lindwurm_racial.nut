::mods_hookExactClass("skills/racial/lindwurm_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}
});
