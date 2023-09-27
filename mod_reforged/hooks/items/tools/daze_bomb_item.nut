
::Reforged.HooksMod.hook("scripts/items/tools/daze_bomb_item", function(q) {
	q.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_daze_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
