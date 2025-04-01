local obj = ::Reforged.InheritHelper.slingItemSkill("throw_holy_water");

// Use MSU.Table.merge to overwrite functions so that function names are preserved in stackinfos
local create = obj.create;
::MSU.Table.merge(obj, {
	function create()
	{
		create();
		this.m.Icon = "skills/rf_sling_holy_water_skill.png";
		this.m.IconDisabled = "skills/rf_sling_holy_water_skill_sw.png";
		this.m.Overlay = "rf_sling_holy_water_skill";
	}
});

this.rf_sling_acid_flask_skill <- ::inherit("scripts/skills/actives/throw_holy_water", obj);
