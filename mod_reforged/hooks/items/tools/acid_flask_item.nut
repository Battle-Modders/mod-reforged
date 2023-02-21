
::mods_hookExactClass("items/tools/acid_flask_item", function(o) {
	o.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_acid_flask_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
