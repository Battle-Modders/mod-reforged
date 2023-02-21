
::mods_hookExactClass("items/tools/smoke_bomb_item", function(o) {
	o.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_smoke_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
