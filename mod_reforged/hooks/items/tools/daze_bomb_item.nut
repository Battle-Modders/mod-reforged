::Reforged.HooksMod.hook("scripts/items/tools/daze_bomb_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 350; // approximately 30% reduced from vanilla value of 500
	}

	q.onPutIntoBag <- function()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_daze_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});
