::Reforged.HooksMod.hook("scripts/items/tools/smoke_bomb_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 275;
	}

	q.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_smoke_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
