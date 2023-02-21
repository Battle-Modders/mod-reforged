
::mods_hookExactClass("items/tools/fire_bomb_item", function(o) {
	o.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_fire_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
