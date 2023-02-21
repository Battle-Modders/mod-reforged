
::mods_hookExactClass("items/tools/daze_bomb_item", function(o) {
	o.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_daze_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
