local obj = ::Reforged.InheritHelper.slingItemSkill("throw_acid_flask");

// Use MSU.Table.merge to overwrite functions so that function names are preserved in stackinfos
local create = obj.create;
::MSU.Table.merge(obj, {
	function create()
	{
		create();
		this.m.Icon = "skills/rf_sling_acid_flask_skill.png";
		this.m.IconDisabled = "skills/rf_sling_acid_flask_skill_sw.png";
		this.m.Overlay = "rf_sling_acid_flask_skill";
	}
});

this.rf_sling_acid_flask_skill <- ::inherit("scripts/skills/actives/throw_acid_flask", obj);
